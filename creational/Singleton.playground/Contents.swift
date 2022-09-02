import Foundation
 // Monostate


class CEO: CustomStringConvertible {
    private static var _name = ""
    private static var _age = 0
    
    var description: String {
        return "\(name) is \(age) years old"
    }
    
    var name: String {
        get {
            type(of: self)._name
        }
        set(value) {
            type(of: self)._name = value
        }
    }
    
    var age: Int {
        get {
            type(of: self)._age
        }
        set(value) {
            type(of: self)._age = value
        }
    }
    
}

func main() {
    var ceo = CEO()
    ceo.name = "Adam Smith"
    ceo.age = 55
    
    var ceo2 = ceo
    ceo.age = 65
    
    print(ceo)
    print(ceo2)
}

main()
