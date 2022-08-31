import Foundation

protocol Copying {
    func clone() -> Self
}

struct Employee: CustomStringConvertible, Copying {

    var name: String
    var address: Address
    var description: String {
        "\(name) with address: \(address)"
    }

    init(_ name: String, _ address: Address) {
        self.name = name
        self.address = address
    }

    func clone() -> Employee {
        return Employee(name, address.clone())
    }
}

class Address: CustomStringConvertible, Copying {
    var streetAddress: String
    var city: String

    var description: String {
        "street: \(streetAddress), city: \(city)"
    }

    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }

    func clone() -> Self {
        cloneImpl()
    }

    private func cloneImpl<T>() -> T {
        return Address(streetAddress, city) as! T
    }
}

func main() {
    let john = Employee("John", Address("123 London Road", "London"))
    var chris = john.clone()

    chris.name = "Chris"
    chris.address.streetAddress = "124 London Road"

    print(john)
    print(chris)
}

main()

