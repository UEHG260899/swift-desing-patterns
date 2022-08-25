import Foundation

class HTMLElement: CustomStringConvertible {

    private let indentSize = 2

    var name = ""
    var text = ""
    var elements = [HTMLElement]()

    var description: String {
        return description(0)
    }

    init() {

    }

    init(name: String, text: String) {
        self.name = name
        self.text = text
    }



    private func description(_ indent: Int) -> String {
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"

        if !text.isEmpty {
            result += String(repeating: " ", count: indent + 1)
            result += text
            result += "\n"
        }

        for e in elements {
            result += e.description(indent + 1)
        }

        result += "\(i)</\(name)>\n"
        return result
    }

}

class HTMLBuilder: CustomStringConvertible {
    private let rootName: String

    var root = HTMLElement()

    var description: String {
        root.description
    }

    init(rootName: String) {
        self.rootName = rootName
        root.name = rootName
    }

    func addChild(name: String, text: String) {
        let e = HTMLElement(name: name, text: text)
        root.elements.append(e)
    }

    func addChildFluent(name: String, text: String) -> HTMLBuilder {
        let e = HTMLElement(name: name, text: text)
        root.elements.append(e)
        return self
    }

    func clear() {
        root = HTMLElement(name: rootName, text: "")
    }
}

func main() {
    let hello = "hello"

    var result = "<p>\(hello)</p>"
    print(result)

    let words = ["hello", "world"]
    result = "<ul>\n"
    words.forEach { result.append("<li>\($0)</li>\n") }

    result.append("</ul>\n")
    print(result)

    let builder = HTMLBuilder(rootName: "ul")
    builder.addChildFluent(name: "li", text: "hello")
            .addChildFluent(name: "li", text: "world")
    print(builder)
}


main()
