import Foundation

class Point: CustomStringConvertible {
    var x, y: Double
    
    var description: String {
        return "x: \(x), y: \(y)"
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    init(rho: Double, theta: Double) {
        self.x = rho * cos(theta)
        self.y = rho * sin(theta)
    }
    
    
}

class PointFactory {
    func createCartesian(x: Double, y: Double) -> Point {
        return Point(x: x, y: y)
    }
    
    func createPolar(rho: Double, theta: Double) -> Point {
        return Point(rho: rho, theta: theta)
    }
}

func main() {
    let factory = PointFactory()
    let cartesian = factory.createCartesian(x: 10, y: 10)
    let polar = factory.createPolar(rho: 10, theta: 10)
    print(cartesian)
}

main()
