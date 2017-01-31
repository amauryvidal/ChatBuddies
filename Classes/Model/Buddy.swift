import UIKit
import CoreData


@objc(Buddy)
class Buddy: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var messages: [Message]
    
    var lastMessage: Message? {
        guard let message = self.messages.filter({ !$0.fromMe }).last else {
            return nil
        }
        return message
    }
    
}

extension Buddy {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Buddy> {
        return NSFetchRequest<Buddy>(entityName: "Buddy")
    }
}
