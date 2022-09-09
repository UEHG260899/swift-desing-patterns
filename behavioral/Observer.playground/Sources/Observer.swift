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
    
    let fallsIll = Event<String>()
    
    init() {
        
    }
    
    func catchCold() {
        fallsIll.raise("123 London Road")
    }
}

class Demo {
    init() {
        let p = Person()
        let sub = p.fallsIll.addHandler(target: self, handler: Demo.callDoctor)
        
        p.catchCold()
        sub.dispose()
    }
    
    func callDoctor(address: String) {
        print("We need a doctor at \(address)")
    }
}

func main() {
    let _ = Demo()
}


main()

