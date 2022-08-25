import Foundation

class Person: CustomStringConvertible {
    var streetAddress = ""
    var postCode = ""
    var city = ""
    var companyName = ""
    var position = ""
    var annualIncome = 0
    
    var description: String {
        "I live at \(streetAddress), \(postCode), \(city) and work at \(companyName) \(position) \(annualIncome)"
    }
}

class PersonBuilder {
    var person = Person()
    var lives: PersonAddressBuilder {
        return PersonAddressBuilder(person)
    }
    
    var works: PersonJobBuilder {
        return PersonJobBuilder(person)
    }
    
    func build() -> Person {
        return person
    }
}


class PersonJobBuilder: PersonBuilder {
    internal init(_ person: Person) {
        super.init()
        self.person = person
    }
    
    func at(_ companyName: String) -> PersonJobBuilder {
        person.companyName = companyName
        return self
    }
    
    func asA(_ position: String) -> PersonJobBuilder {
        person.position = position
        return self
    }
    
    func earning(_ annualIncome: Int) -> PersonJobBuilder {
        person.annualIncome = annualIncome
        return self
    }
}

class PersonAddressBuilder: PersonBuilder {
    internal init(_ person: Person) {
        super.init()
        self.person = person
    }
    
    func at(_ streetAddress: String) -> PersonAddressBuilder {
        person.streetAddress = streetAddress
        return self
    }
    
    func withPostalCode(_ postCode: String) -> PersonAddressBuilder {
        person.postCode = postCode
        return self
    }
    
    func inCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }
}

func main() {
    let personBuilder = PersonBuider()
    let person = personBuilder.lives.at("123 London Road")
        .inCity("London")
        .withPostalCode("50140")
        .works
        .at("Globant")
        .asA("Developer")
        .earning("37k")
        .build()
    
    print(person)
}

main()
