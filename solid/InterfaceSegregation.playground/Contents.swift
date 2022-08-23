import Foundation

class Document {
    
}

// Wring
//protocol Machine {
//    func print(d: Document)
//    func scan(d: Document)
//    func fax(d: Document)
//}

protocol Printer {
    func print(d: Document)
}

protocol Scanner {
    func scan(d: Document)
}

protocol Fax {
    func fax(d: Document)
}

protocol MultiFunctionDevice: Printer, Scanner, Fax {
    
}
