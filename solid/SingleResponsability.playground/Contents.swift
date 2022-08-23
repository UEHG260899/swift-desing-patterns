import Foundation

class Journal: CustomStringConvertible {
    var entries = [String]()
    var count = 0
    var description: String {
        return entries.joined(separator: "\n")
    }
    
    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }
    
    func removeEntry(_ index: Int) {
        entries.remove(at: index)
    }
    
//    This goes in another class to not violate Single Responsability principle
//    func save(_ fileName: String, _ overwrite: Bool = false) {
//        // save to a file
//    }
//
//    func load(_ fileName: String) {
//
//    }
}

class Persistance {
    func saveToFile(_ journal: Journal, _ fileName: String) {
        
    }
}

func main() {
    let journal = Journal()
    let _ = journal.addEntry("I cried today")
    let bug = journal.addEntry("I ate a bug")
    
    print(journal)
    
    journal.removeEntry(bug)
    print("===")
    print(journal)
    
    let persistance = Persistance()
    let fileName = "fiehfioehe"
    persistance.saveToFile(journal, fileName)
}

main()
