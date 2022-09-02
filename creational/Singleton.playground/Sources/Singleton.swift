import Foundation

class SingletonDatabase {
    var capitals = [String: Int]()
    
    static let instance = SingletonDatabase()
    static var instanceCount = 0
    
    private init() {
        type(of: self).instanceCount += 1
        print("initializing DB")
    }
}


func main() {
    let db = SingletonDatabase.instance
    print(SingletonDatabase.instanceCount)
    
    let db2 = SingletonDatabase.instance
    print(SingletonDatabase.instanceCount)
}

main()
