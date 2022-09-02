import Foundation

class Point: CustomStringConvertible, Hashable {
    var x,y: Int
    
    var description: String {
        "(\(x), \(y))"
    }
        
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x * 397 + y)
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}


class Line: Hashable {
    var start: Point
    var end: Point
    
    init(_ start: Point, _ end: Point) {
        self.start = start
        self.end = end
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(start.hashValue + end.hashValue)
    }
    
    static func ==(lhs: Line, rhs: Line) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}


class Vector: Sequence {
    var lines = [Line]()
    
    func makeIterator() -> IndexingIterator<Array<Line>> {
        return IndexingIterator(_elements: lines)
    }
}


class VectorRectangle: Vector {
    
    init(_ x: Int, _ y: Int, _ width: Int, _ height: Int) {
        super.init()
        lines.append(Line(Point(x, y), Point(x + width, y)))
        lines.append(Line(Point(x + width, y), Point(x + width, y + height)))
        lines.append(Line(Point(x, y), Point(x, y + height)))
        lines.append(Line(Point(x, y + height), Point(x + width, y + height)))
    }
}

class LineToPointAdapter: Sequence {
    
    private static var count = 0
    static var cache = [Int: [Point]]()
    
    var hash: Int
    
    init(_ line: Line) {
        hash = line.hashValue
        
        if type(of: self).cache[hash] != nil {
            return
        }
    }
    
    func makeIterator() -> IndexingIterator<Array<Point>> {
        return IndexingIterator(_elements: type(of: self).cache[hash]!)
    }
}


func drawPoint(_ p: Point) {
    print(".", terminator: "")
}

let vectorObjects = [
    VectorRectangle(1, 1, 10, 10),
    VectorRectangle(3, 3, 6, 6)
]

func draw() {
    for vo in vectorObjects {
        for line in vo {
            let adapter = LineToPointAdapter(line)
            adapter.forEach { drawPoint($0) }
        }
    }
}

func main() {
    draw()
    draw()
}

main()


