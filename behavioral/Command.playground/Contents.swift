import Foundation

class BankAccount: CustomStringConvertible {
    private var balance = 0
    private let overdraftLimit = -500
    
    var description: String {
        "Balance \(balance)"
    }
    
    func deposit(_ amount: Int) {
        balance += amount
        print("Deposited")
    }
    
    func withdraw(_ amount: Int) -> Bool {
        if balance - amount >= overdraftLimit {
            print("withdrawed")
            balance -= amount
            return true
        }
        
        return false
    }
}

protocol Command {
    func call()
    func undo()
}

class BankAccountCommand: Command {
    private var account: BankAccount
    
    enum Action {
        case deposit
        case withdraw
    }
    
    private var action: Action
    private var amount: Int
    private var succeeded = false
    
    init(_ account: BankAccount, _ action: Action, _ amoun: Int) {
        self.account = account
        self.action = action
        self.amount = amoun
    }
    
    func call() {
        switch action {
        case .deposit:
            account.deposit(amount)
            succeeded = true
        case .withdraw:
            succeeded = account.withdraw(amount)
        }
    }
    
    func undo() {
        
        guard succeeded else  {
            return
        }
        
        switch action {
        case .deposit:
            account.withdraw(amount)
            succeeded = true
        case .withdraw:
            account.deposit(amount)
        }
    }
}

func main() {
    let account = BankAccount()
    
    let commands = [
        BankAccountCommand(account, .deposit, 100),
        BankAccountCommand(account, .withdraw, 25)
    ]
    
    print(account)
    
    commands.forEach { $0.call() }
    
    print(account)
    
    commands.last?.undo()
    
    print(account)
}

main()
