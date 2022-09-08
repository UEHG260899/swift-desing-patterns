import Foundation


class Memento {
    let balance: Int
    
    init(_ balance: Int) {
        self.balance = balance
    }
}


class BankAccount: CustomStringConvertible {
    private var balance: Int
    private var changes = [Memento]()
    private var current = 0
    
    var description: String {
        "\(balance)"
    }
    
    init(_ balance: Int) {
        self.balance = balance
        changes.append(Memento(balance))
    }
    
    func deposit(_ amount: Int) -> Memento {
        balance += amount
        let m = Memento(balance)
        changes.append(m)
        current += 1
        return m
    }
    
    func restore(_ m: Memento?) {
        if let m = m {
            balance = m.balance
            changes.append(m)
            current = changes.count - 1
        }
        
    }
    
    func undo() -> Memento? {
        if current > 0 {
            current -= 1
            let m = changes[current]
            balance = m.balance
            return m
        }
        
        return nil
    }
    
    func redo() -> Memento? {
        if (current + 1) < changes.count {
            current += 1
            let m = changes[current]
            balance = m.balance
            return m
        }
        
        return nil
    }
}

func main() {
    let account = BankAccount(100)
    _ = account.deposit(50)
    _ = account.deposit(25)
    print(account)
    
    account.undo()
    print("Undo 1: \(account)")
    account.undo()
    print("Undo 2: \(account)")
    account.redo()
    print("Redo: \(account)")
}

main()
