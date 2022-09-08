import Foundation

class Node<T> {
    var value: T
    var left: Node<T>? = nil
    var right: Node<T>? = nil
    var parent: Node<T>? = nil
    
    init(_ value: T) {
        self.value = value
    }
    
    init(value: T, left: Node<T>, right: Node<T>) {
        self.value = value
        self.left = left
        self.right = right
        
        left.parent = self
        right.parent = self
    }
}

class InOrderIterator<T>: IteratorProtocol {
    var current: Node<T>?
    var root: Node<T>
    var yieldStart = false
    
    init(root: Node<T>) {
        self.root = root
        current = root
        
        while current?.left != nil {
            current = current?.left
        }
    }

    func reset() {
        current = root
        yieldStart = true
    }
    
    func next() -> Node<T>? {
        if !yieldStart {
            yieldStart = true
            return current
        }
        
        if current?.right != nil {
            current = current?.right
            
            while current?.left != nil {
                current = current?.left
            }
            
            return current
        } else {
            var p = current?.parent
            
            while p != nil && current === p?.right {
                current = p
                p = p?.parent
            }
            
            current = p
            return current
        }
    }
}

func main() {
    let root = Node(value: 1, left: Node(2), right: Node(3))
    
    let it = InOrderIterator(root: root)
    
    while let element = it.next() {
        print(element.value)
    }
}

main()

