import Foundation

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    var isNumber: Bool {
        get {
            return !self.isEmpty && (self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil)
        }
    }
}


struct Token: CustomStringConvertible {
    enum TokenType {
        case integer
        case plus
        case minus
        case lparen
        case rparen
    }
    
    var tokenType: TokenType
    var text: String
    
    var description: String {
        "\(text)"
    }
    
    init(_ tokenType: TokenType, _ text: String) {
        self.tokenType = tokenType
        self.text = text
    }
}

func lex(_ input: String) -> [Token] {
    var result = [Token]()
    var i = 0
    
    while i < input.count {
        switch input[i] {
        case "+":
            result.append(Token(.plus, "+"))
        case "-":
            result.append(Token(.minus, "-"))
        case "(":
            result.append(Token(.lparen, "("))
        case ")":
            result.append(Token(.rparen, ")"))
        default:
            var string = String(input[i])
            for j in (i + 1)..<input.count {
                if String(input[j]).isNumber {
                    string.append(input[j])
                    i += 1
                } else {
                    result.append(Token(.integer, string))
                    break
                }
            }
        }
        
        i += 1
    }
    
    return result
}

protocol Element {
    var value: Int { get }
}

class Integer: Element {
    var value: Int
    
    init(_ value: Int) {
        self.value = value
    }
}

class BinaryOperation: Element {
    enum OpType {
        case addition
        case substraction
    }
    
    var opType: OpType = .addition
    var left = Integer(0)
    var right = Integer(0)
    
    var value: Int {
        switch opType {
        case .addition:
            return left.value + right.value
        case .substraction:
            return left.value - right.value
        }
    }
    
    init() {
        
    }
    
    init(_ left: Integer, _ right: Integer, _ opType: OpType) {
        self.left = left
        self.right = right
        self.opType = opType
    }
    
    func parse(_ tokens: [Token]) -> Element {
        let result = BinaryOperation()
        var haveLHS = false
        
        var i = 0
        
        while i < tokens.count {
            let token  = tokens[i]
            
            switch token.tokenType {
            case .integer:
                let integer = Integer(Int(token.text)!)
                if !haveLHS {
                    result.left = integer
                    haveLHS = true
                } else {
                    result.right = integer
                }
            case .plus:
                result.opType = .addition
            case .minus:
                result.opType = .substraction
            case .lparen:
                // more code
                print("")
            case .rparen:
                // even more code
                print("")
            }
            
            i += 1
        }
        
        return result
    }
}

func main() {
    let input = "(13+4)-(12-1)"
    let tokens = lex(input)
    print(tokens)
}

main()
