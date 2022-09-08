import Foundation

protocol Log {
    func info(_ msg: String)
    func warn(_ msg: String)
}

class ConsoleLog: Log {
    func info(_ msg: String) {
        print(msg)
    }

    func warn(_ msg: String) {
        print("WARN: \(msg)")
    }


}

class BankAccount {
    var balance: Int = 0
    var log: Log

    init(_ log: Log) {
        self.log = log
    }

    func deposit(_ amount: Int) {
        balance += amount
        log.info("Deposited \(amount)")
    }
}

class NullLog: Log {
    func info(_ msg: String) {

    }
    func warn(_ msg: String) {

    }
}


func main() {
    let log = NullLog()

    let account = BankAccount(log)
    account.deposit(100)
}

main()

