import Foundation

protocol Invocable: AnyObject {
    func invoke(_ data: Any)
}

protocol Disposable {
    func dispose()
}

class Event<T> {
    typealias EventHandler = (T) -> Void
    
    var eventHandlers = [Invocable]()
    
    func raise(_ data: T) {
        for handler in eventHandlers {
            handler.invoke(data)
        }
    }
    
    func addHandler<U: AnyObject>(target: U, handler: @escaping (U) -> EventHandler) -> Disposable {
        let subscription = Subscription(target: target, handler: handler, event: self)
        eventHandlers.append(subscription)
        return subscription
    }
}

class Subscription<T: AnyObject, U>: Invocable, Disposable {
    
    weak var target: T?
    let handler: (T) -> (U) -> Void
    let event: Event<U>
    
    init(target: T?, handler: @escaping (T) -> (U) -> Void, event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event
    }
    
    func invoke(_ data: Any) {
        if let target = target {
            handler(target)(data as! U)
        }
    }
    
    func dispose() {
        event.eventHandlers = event.eventHandlers.filter { $0 as AnyObject? !== self }
    }
    
    
}


class Person {
    
    private var oldCanVote = false
    
    var age: Int = 0 {
        willSet(newValue) {
            print("About to set the age to \(newValue)")
            oldCanVote = canVote
        }
        didSet {
            print("We just changed age from \(oldValue) to \(age)")
            
            if age != oldValue {
                propertyChanged.raise(("age", age))
            }
            
            if canVote != oldCanVote {
                propertyChanged.raise(("canVote", canVote))
            }
        }
    }
    
    var canVote: Bool {
        return age >= 16
    }
    
    let propertyChanged = Event<(String, Any)>()
}

final class RefBool {
    var value: Bool
    
    init(_ value: Bool) {
        self.value = value
    }
}

class Person2 {
    private var _age: Int = 0
    
    var age: Int {
        get {
            return _age
        }
        set(value) {
            if _age == value { return }
            
            // cache
            let oldCanVote = canVote
            
            var cancelSet = RefBool(false)
            propertyChanging.raise(("age", value, cancelSet))
            
            if cancelSet.value {
                return
            }
            
            // assign an notify
            _age = value
            propertyChanged.raise(("age", _age))
            
            if oldCanVote != canVote {
                propertyChanged.raise(("canVote", canVote))
            }
            
        }
    }
    
    var canVote: Bool {
        return age >= 16
    }
    
    let propertyChanged = Event<(String, Any)>()
    let propertyChanging = Event<(String, Any, RefBool)>()
}


class Demo {
    init() {
//        let p = Person()
//        p.propertyChanged.addHandler(target: self, handler: Demo.propChanged)
//        p.age = 20
//        p.age = 22
        let p = Person2()
        p.propertyChanged.addHandler(target: self, handler: Demo.propChanged)
        p.propertyChanging.addHandler(target: self, handler: Demo.propChanging)
        p.age = 20
        p.age = 22
        
        p.age = 12
    }
    
    func propChanged(args: (String, Any)) {
        if args.0 == "age" {
            print("Age changed \(args.1)")
        } else if args.0 == "canVote" {
            print("Voting status has changed to \(args.1)")
        }
    }
    
    func propChanging(args: (String, Any, RefBool)) {
        if args.0 == "age", (args.1 as! Int) < 14 {
            print("Cannot do that")
            args.2.value = true
        }
    }
}

let _ = Demo()

