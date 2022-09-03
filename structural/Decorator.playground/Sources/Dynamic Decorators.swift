import Foundation

protocol Shape: CustomStringConvertible {
    var description: String { get }
}

class Circle: Shape {
    private var radius: Float = 0
    
    var description: String {
        return "A circle of radius: \(radius)"
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
    
    init(_ side: Float) {
        self.side = side
    }
}

class ColoredShape: Shape {
    var shape: Shape
    var color: String
    
    
    var description: String {
        return "\(shape) has color \(color)"
    }
    
    init(_ shape: Shape, _ color: String) {
        self.shape = shape
        self.color = color
    }
}

class TransparentShape: Shape {
    var shape: Shape
    var transparency: Float
    
    var description: String {
        return "\(shape) has \(transparency * 100) transparency"
    }
    
    init(_ shape: Shape, _ transparency: Float) {
        self.shape = shape
        self.transparency = transparency
    }
}

func main() {
    let square = Square(1.23)
    print(square)
    
    let redSquare = ColoredShape(square, "red")
    print(redSquare)
    
    let transparentRedSquare = TransparentShape(redSquare, 0.5)
    print(transparentRedSquare.description)
}

main()

