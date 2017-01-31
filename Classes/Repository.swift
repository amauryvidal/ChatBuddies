import Foundation
import CoreData


class Repository: NSObject {
    var delegate: AppDelegate

    init(delegate:AppDelegate) {
        self.delegate = delegate
    }

    func findBuddies() -> [Buddy] {
//        return self.delegate.findAllOfEntity("Buddy").map { ($0 as! Buddy) }
        return [Buddy]()
    }
//
    func findMessages() -> [Message] {
//        return self.delegate.findAllOfEntity("Message").map { ($0 as! Message) }
        return [Message]()
    }
//
    func buddyWithName(_ name: String) -> Buddy {
//        let result: Buddy = self.delegate.entityForName("Buddy") as! Buddy
//        result.name = name
//        return result
        return Buddy()
    }
//
    func asyncSave() {
//        self.delegate.perform("save", with: nil, afterDelay: 0)
    }
}
