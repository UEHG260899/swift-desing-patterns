import Foundation

class GraphicObject: CustomStringConvertible {
    
    var name: String = "Group"
    var color: String = ""
    var children = [GraphicObject]()
    
    
    var description: String {
        var buffer = ""
        print(&buffer, 0)
        return buffer
    }
    
    init() {
        
    }
    
    init(_ name: String) {
        self.name = name
    }
    
    private func print(_ buffer: inout String, _ depth: Int) {
        buffer.append(String(repeating: "*", count: depth))
        buffer.append(color.isEmpty ? "" : "\(color) ")
        buffer.append("\(name)\n")
        
        for child in children {
            child.print(&buffer, depth + 1)
        }
    }
}

class Square: GraphicObject {
    
    override init(_ color: String) {
        super.init("Square")
        self.color = color
    }
}


class Circle: GraphicObject {
    
    override init(_ color: String) {
        super.init("Circle")
        self.color = color
    }
}


func main() {
    let drawing = GraphicObject("My drawing")
    drawing.children.append(Square("Red"))
    drawing.children.append(Circle("Yellow"))
    
    let group = GraphicObject()
    group.children.append(Circle("Black"))
    drawing.children.append(group)
    
    print(drawing.description)
}

main()
