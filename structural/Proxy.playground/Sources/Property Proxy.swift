import Foundation

class Property<T: Equatable> {
    private var _value: T
    
    public var value: T {
        get {
            return _value
        }
        set(value) {
            if value == _value { return }
            print("Setting value to \(value)")
            _value = value
        }
    }
    
    init(_ value: T) {
        self._value = value
    }
}

extension Property: Equatable {
    static func == <T>(lhs: Property<T>, rhs: Property<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

class Creature {
    private let _ability = Property<Int>(0)
    
    var agility: Int {
        get {
            return _ability.value
        }
        set(value) {
            _ability.value = value
        }
    }
}

