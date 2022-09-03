import Foundation

protocol ICanFly {
    func fly()
}

protocol ICanCrawl {
    func crawl()
}

class Bird: ICanFly {
    func fly() {
        
    }
}

class Lizard: ICanCrawl {
    func crawl() {
        
    }
}

class Dragon: ICanFly, ICanCrawl {
    private let bird = Bird()
    private let lizard = Lizard()
    
    func fly() {
        bird.fly()
    }
    
    func crawl() {
        lizard.crawl()
    }
}
