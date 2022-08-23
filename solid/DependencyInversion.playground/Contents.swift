import Foundation

enum Relationship {
    case parent
    case child
    case sibling
}

class Person {
    var name = ""
    
    init(_ name: String) {
        self.name = name
    }
}


protocol RelationshipBrowser {
    func findAllChildrenOf(_ name: String) -> [Person]
}

class Relationships: RelationshipBrowser {
    private var relations = [(Person, Relationship, Person)]()
    
    func addParentAndChild(_ p: Person, _ c: Person) {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }
    
    func findAllChildrenOf(_ name: String) -> [Person] {
        return relations.filter { person1, relationship, _ in
            return person1.name == name && relationship == .parent
        }
        .map {$2}
    }
}


class Research {
//    init(_ relationships: Relationships) {
//        let relationships = relationships.relations
//
//        for r in relationships where r.0.name == "John" && r.1 == .parent {
//            print("John has a child called \(r.2.name)")
//        }
//    }
    
    init(_ browser: RelationshipBrowser) {
        for p in browser.findAllChildrenOf("John") {
            print("John has a child \(p.name)")
        }
    }
}


func main() {
    let parent = Person("John")
    let child1 = Person("Chris")
    let child2 = Person("Matt")
    
    let relationships = Relationships()
    relationships.addParentAndChild(parent, child1)
    relationships.addParentAndChild(parent, child2)
    
    let _ = Research(relationships)
}

main()
