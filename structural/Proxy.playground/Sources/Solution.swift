import Foundation

protocol HumanBeing {
    func drink() -> String
    func drive() -> String
    func drinkAndDrive() -> String
}

class Person: HumanBeing {
    var age: Int = 0

    func drink() -> String {
        return "drinking"
    }

    func drive() -> String {
        return "driving"
    }

    func drinkAndDrive() -> String {
        return "driving while drunk"
    }
}

class ResponsiblePerson: HumanBeing {
    private let person: Person
    var age: Int

    init(person: Person) {
        self.person = person
        self.age = person.age
    }

    func drink() -> String {
        if self.age < 18 {
            return "too young"
        }

        return person.drink()
    }

    func drive() -> String {
        if self.age < 16 {
            return "too young"
        }

        return person.drive()
    }

    func drinkAndDrive() -> String {
        return "dead"
    }
}
