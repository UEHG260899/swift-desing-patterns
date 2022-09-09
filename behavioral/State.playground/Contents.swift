import Foundation

enum State {
    case offHook
    case connecting
    case connected
    case onHold
}

enum Trigger {
    case callDialed
    case hungUp
    case callConnected
    case takenOffHold
    case leftMessage
}

let rules = [
    State.offHook: [
        (Trigger.callDialed, State.connecting)
    ],
    State.onHold: [
        (Trigger.takenOffHold, State.connected),
        (Trigger.hungUp, State.offHook)
    ]
]

func main() {
    var state = State.offHook
    
    while true {
        print("The phone is currently \(state)")
        
        for i in 0..<rules[state]!.count {
            let (t, _) = rules[state]![i]
            print("\(i). \(t)")
        }
        
        if let input = Int(readLine()!) {
            let (_, s) = rules[state]![input]
            state = s
        }
    }
}

main()
