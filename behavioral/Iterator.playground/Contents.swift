import Foundation

class Creature {
//    var strength, agility, intelligence: Int
//
//    var averageState: Int {
//        return (strength + agility + intelligence) /3
//    }
    
    private let _strenght = 0
    private let _agility = 1
    private let _intelligence = 2
    
    var stats = [Int](repeating: 0, count: 3)
    
    var strength: Int {
        get {
            return stats[_strenght]
        }
        set(value) {
            stats[_strenght] = value
        }
    }
    
    var averageStat: Float {
        return Float(stats.reduce(0, +) / stats.count)
    }
    
    subscript(index: Int) -> Int {
        get {
            return stats[index]
        }
        set(value) {
            stats[index] = value
        }
    }
}
