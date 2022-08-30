import Foundation

class Point: CustomStringConvertible {
    var x, y: Double
    
    var description: String {
        return "x: \(x), y: \(y)"
    }
    
    private init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    private init(rho: Double, theta: Double) {
        self.x = rho * cos(theta)
        self.y = rho * sin(theta)
    }
    
    static func createCartesian(x: Double, y: Double) -> Point {
        return Point(x: x, y: y)
    }
    
    static func createPolar(rho: Double, theta: Double) -> Point {
        return Point(rho: rho, theta: theta)
    }
}


func main() {
    let p = Point.createCartesian(x: 10, y: 10)
    print(p)
}

main()
