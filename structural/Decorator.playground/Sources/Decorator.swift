import Foundation

class CodeBuilder: CustomStringConvertible {
    private var buffer: String = ""
    
    var description: String {
        buffer
    }
    
    init() {
        
    }
    
    init(_ buffer: String) {
        self.buffer = buffer
    }
    
    func append(_ s: String) -> CodeBuilder {
        buffer.append(s)
        return self
    }
    
    func appendLine(_ s: String) -> CodeBuilder {
        buffer.append("\(s)\n")
        return self
    }
    
    static func +=(cb: inout CodeBuilder, s: String) {
        cb.buffer.append(s)
    }
}

func main() {
    var cb = CodeBuilder()
    cb.appendLine("class Foo")
        .appendLine("{")
    
    cb += "  // testing\n"
    
    cb.appendLine("}")
    
    print(cb)
}

main()

