import Foundation

// Static Decorator

protocol Shape: CustomStringConvertible {
    init()
    var description: String { get }
}

class Circle: Shape {
    private var radius: Float = 0
    
    var description: String {
        return "A Circle of radius: \(radius)"
    }
    
    required init() {
        
    }
    
    init(_ radius: Float) {
        self.radius = radius
    }
    
    func resize(_ factor: Float) {
        radius *= factor
    }
}

class Square: Shape {
    private var side: Float = 0
    
    var description: String {
        return "Square with side: \(side)"
    }
    
    required init() {
        
    }
    
    init(_ side: Float) {
        self.side = side
    }
}

class ColoredShape<T>: Shape where T: Shape {
    
    private var color: String = "black"
    private var shape: T = T()
    
    
    var description: String {
        return "\(shape) has color \(color)"
    }
    
    required init() {
        
    }
    
    init(_ color: String) {
        self.color = color
    }
}

class TransparentShape<T>: Shape where T: Shape {

    private var transparency: Float = 0.0
    private var shape: T = T()
    
    var description: String {
        return "\(shape) has \(transparency * 100) transparency"
    }
    
    required init() {
        
    }
    
    init(_ transparency: Float) {
        self.transparency = transparency
    }
}

func main() {
    let blueCircle = ColoredShape<Circle>("blue")
    print(blueCircle)
    
    let blackHalfhSquare = TransparentShape<ColoredShape<Square>>(0.5)
    print(blackHalfhSquare)
}

main()
