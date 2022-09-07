import Foundation

class Creature: CustomStringConvertible {
    var name: String
    var attack: Int
    var defense: Int
    
    init(name: String, attack: Int, defense: Int) {
        self.name = name
        self.attack = attack
        self.defense = defense
    }
    
    var description: String {
        "Name: \(name) Attack: \(attack) Defense: \(defense)"
    }
}

class CreatureModifier {
    let creature: Creature
    var next: CreatureModifier?
    
    init(creature: Creature) {
        self.creature = creature
    }
    
    func add(_ cm: CreatureModifier) {
        if next != nil {
            next!.add(cm)
        } else {
            next = cm
        }
    }
    
    func handle() {
        next?.handle()
    }
}


class DoubleAttackModifier: CreatureModifier {
    override func handle() {
        print("Doubling \(creature.name) attack")
        creature.attack *= 2
        super.handle()
    }
}

class IncreaseDefenseModifier: CreatureModifier {
    override func handle() {
        creature.defense += 3
        super.handle()
    }
}

func main() {
    let creature = Creature(name: "Goblin", attack: 2, defense: 2)
    print(creature)
    
    let root = CreatureModifier(creature: creature)
    
    print("Double goblin attack")
    root.add(DoubleAttackModifier(creature: creature))
    
    print("Increasing goblins defense")
    root.add(IncreaseDefenseModifier(creature: creature))
    
    
    root.handle()
    print(creature)
}

main()

