import Foundation

enum Color {
    case red
    case green
    case blue
}

enum Size {
    case small
    case medium
    case large
    case huge
}


class Product {
    var name: String
    var color: Color
    var size: Size
    
    init(_ name: String, _ color: Color, _ size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
}

class ProductFilter {
    func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
        return products.filter { $0.color == color }
    }
    
//    Breaks Open Closed Principle
//    func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
//        return products.filter { $0.size == size }
//    }
}

// Specification
protocol Specification {
    
    associatedtype T
    
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ item: [T], _ spec: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    typealias T = Product
    
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    
    let size: Size
    
    init(_ size: Size) {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AnddSpecification<T, SpecA: Specification, SpecB: Specification>: Specification where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T {
    let specA: SpecA
    let specB: SpecB
    
    init(_ first: SpecA, _ second: SpecB) {
        self.specA = first
        self.specB = second
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return specA.isSatisfied(item) && specB.isSatisfied(item)
    }
}

class BetterFilter: Filter {
    typealias T = Product
    
    func filter<Spec>(_ item: [Product], _ spec: Spec) -> [Product] where Spec : Specification, Product == Spec.T {
        var result = [Product]()
        
        for i in item {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        
        return result
    }
}

func main() {
    let apple = Product("Apple", .green, .small)
    let tree = Product("Tree", .green, .large)
    let house = Product("House", .blue, .large)
    
    let products = [apple, tree, house]
    
    let productFilter = ProductFilter()
    
    for product in productFilter.filterByColor(products, .green) {
        print(product.name)
    }
    
    let betterFilter = BetterFilter()
    print("Green products new:")
    for p in betterFilter.filter(products, ColorSpecification(.green)) {
        print(p.name)
    }
    
    print("Large blue items")
    for product in betterFilter.filter(products, AnddSpecification(ColorSpecification(.blue), SizeSpecification(.large))) {
        print(product.name)
    }
}

main()
