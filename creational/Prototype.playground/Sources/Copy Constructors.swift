import Foundation

import Foundation

protocol Copying {
    init(copyFrom other: Self)
}

class Employee: CustomStringConvertible, Copying {
    var name: String
    var address: Address
    var description: String {
        "\(name) with address: \(address)"
    }
    
    required init(copyFrom other: Employee) {
        name = other.name
        address = Address(copyFrom: other.address)
    }
    
    init(_ name: String, _ address: Address) {
        self.name = name
        self.address = address
    }
}

class Address: CustomStringConvertible, Copying {
    var streetAddress: String
    var city: String
    
    var description: String {
        "street: \(streetAddress), city: \(city)"
    }
    
    required init(copyFrom other: Address) {
        streetAddress = other.streetAddress
        city = other.city
    }
    
    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }
}


func main() {
    let john = Employee("John", Address("123 London Road", "London"))
    let chris = Employee(copyFrom: john)
    
    chris.name = "Chris"
    chris.address.streetAddress = "124 London Road"
    
    print(john)
    print(chris)
}

main()
