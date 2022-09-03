import Foundation

class Buffer {
    var width, height: Int
    var buffer: [Character]
    
    init(_ width: Int, height: Int) {
        self.width = width
        self.height = height
        buffer = [Character](repeating: " ", count: width * height)
    }
    
    subscript(_ index: Int) -> Character {
        return buffer[index]
    }
}

class ViewPort {
    var buffer: Buffer
    var offset = 0
    
    init(_ buffer: Buffer) {
        self.buffer = buffer
    }
    
    func getCharacterAt(_ index: Int) -> Character {
        return buffer[offset + index]
    }
}

class Console {
    var buffers = [Buffer]()
    var viewports = [ViewPort]()
    var offset = 0
    
    init() {
        let b = Buffer(30, height: 20)
        let v = ViewPort(b)
        buffers.append(b)
        viewports.append(v)
        
    }
    
    func getCharacterAt(_ index: Int) -> Character? {
        return viewports.first?.getCharacterAt(index)
    }
}


func main() {
    let c = Console()
    let u = c.getCharacterAt(1)
    print(u)
}

main()
