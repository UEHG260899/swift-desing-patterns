import Foundation

class Rectangle: CustomStringConvertible {
    var _width = 0
    var _height = 0
    
    var width: Int {
        get {
            return _width
        }
        set(value) {
            _width = value
        }
    }
    
    var height: Int {
        get {
            return _height
        }
        set(value) {
            _height = value
        }
    }
    
    var area: Int {
        return _width * _height
    }
    
    var description: String {
        return "width: \(width) height: \(height)"
    }
    
    init() {}
    
    init(_ width: Int, _ height: Int) {
        _width = width
        _height = height
    }
}


class Square: Rectangle {
    override var width: Int {
        get {
            return _width
        }
        set(value) {
            _width = value
            _height = value
        }
    }
    
    override var height: Int {
        get {
            return _height
        }
        set(value) {
            _width = value
            _height = value
        }
    }
}

func setAndMeasure(_ rc: Rectangle) {
    rc.width = 3
    rc.height = 4
    print("Expected area to be 12 but gut \(rc.area)")
}

func main() {
    let rc = Rectangle()
    let square = Square()
    setAndMeasure(rc)
    setAndMeasure(square)
}

main()
