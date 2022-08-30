import Foundation

class Point: CustomStringConvertible {
    private var x, y: Double
    
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
    
    
}

extension Point {
    
    static let factory = PointFactory.instance
    
    class PointFactory {
        
        static let instance = PointFactory()
        
        private init() {}
        
        func createCartesian(x: Double, y: Double) -> Point {
            return Point(x: x, y: y)
        }
        
        func createPolar(rho: Double, theta: Double) -> Point {
            return Point(rho: rho, theta: theta)
        }
    }
}



func main() {
    let factory = Point.factory
    let cartesian = factory.createCartesian(x: 10, y: 10)
    let polar = factory.createPolar(rho: 10, theta: 10)
    print(cartesian)
}

main()
