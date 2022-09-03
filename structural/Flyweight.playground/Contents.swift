import Foundation

class User {
    var fullName: String
    
    var charCount: Int {
        return fullName.utf8.count
    }
    
    init(_ fullName: String) {
        self.fullName = fullName
    }
}

class User2 {
    static var strings = [String]()
    static var charCount: Int {
        return strings.map { $0.utf8.count }.reduce(0, +)
    }
    
    private var names = [Int]()
    
    init(_ fullName: String) {
        func getOrAdd(_ s: String) -> Int {
            if let idx = User2.strings.firstIndex(of: s) {
                return idx
            } else {
                User2.strings.append(s)
                return User2.strings.count - 1
            }
        }
        
        names = fullName.components(separatedBy: " ").map { getOrAdd($0) }

    }
}

func main() {
    let u1 = User("John Smith")
    let u2 = User("Jane Smith")
    let u3 = User("Jane Doe")
    
    let totalChars = u1.charCount + u2.charCount + u3.charCount
    print(totalChars)
    
    let u4 = User2("John Smith")
    let u5 = User2("Jane Smith")
    let u6 = User2("Jane Doe")
    
    print(User2.charCount)
}

main()

