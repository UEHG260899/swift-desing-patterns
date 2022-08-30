import Foundation

protocol HotDrink {
    func consume()
}

class Tea: HotDrink {
    func consume() {
        print("This tea is nice but I´d prefer it with lemon.")
    }
}

class Coffee: HotDrink {
    func consume() {
        print("This coffe is delicious!")
    }
}

protocol HotDrinkFactory {
    init()
    func prepare(amount: Int) -> HotDrink
}

class TeaFactory: HotDrinkFactory {
    required init() {
        
    }
    
    func prepare(amount: Int) -> HotDrink {
        return Tea()
    }
}

class CoffeeFactory: HotDrinkFactory {
    
    required init () {
        
    }
    
    func prepare(amount: Int) -> HotDrink {
        return Coffee()
    }
    
    
}

class HotDrinkMachine {
    enum AvailableDrink: String, CaseIterable {
        case cofee = "Coffee"
        case tea = "Tea"
    }
    
    internal var factories = [AvailableDrink: HotDrinkFactory]()
    internal var namedFactories = [(String, HotDrinkFactory)]()
    
    init() {
        for drink in AvailableDrink.allCases {
            let type = NSClassFromString("Factories.\(drink.rawValue)Factory")
            let factory = (type as! HotDrinkFactory.Type).init()
            factories[drink] = factory
        }
    }
    
}
