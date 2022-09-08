import Foundation

class Person {
    var name: String
    var chatRoom: ChatRoom? = nil
    
    private var chatLog = [String]()
    
    init(_ name: String) {
        self.name = name
    }
    
    func receive(sender: String, message: String) {
        let s = "\(sender): \(message)"
        print("[\(name)'s chat session] \(s)")
        chatLog.append(s)
    }
    
    func pm(to target: String, message: String) {
        chatRoom?.message(sender: name, destination: target, message: message)
    }
    
    func say(_ message: String) {
        chatRoom?.broadcast(sender: name, message: message)
    }
}

class ChatRoom {
    private var people = [Person]()
    
    func broadcast(sender: String, message: String) {
        for person in people {
            if person.name != sender {
                person.receive(sender: sender, message: message)
            }
        }
    }
    
    func join(_ p: Person) {
        let joinMsg = "\(p.name) joins the chat"
        broadcast(sender: "room", message: joinMsg)
        p.chatRoom = self
        people.append(p)
    }
    
    func message(sender: String, destination: String, message: String) {
        people.first { $0.name == destination }?.receive(sender: sender, message: message)
    }
}

func main() {
    let room = ChatRoom()
    
    let john = Person("john")
    let jane = Person("jane")
    
    room.join(john)
    room.join(jane)
    
    john.say("Hi room")
    jane.say("Hi john")
    
    let simon = Person("simon")
    room.join(simon)
    simon.say("hi everyone")
    
    jane.pm(to: "simon", message: "glad you could join us!")
}

main()
