import Foundation
import CoreData

@objc(Message)
class Message: NSManagedObject {
    @NSManaged var text: String
    @NSManaged var source: Buddy

    var time: Date {
        let time = self.primitiveValue(forKey: "timeSinceReferenceDate") as! Double
        return Date(timeIntervalSinceReferenceDate: time)
    }
    
    var fromMe: Bool {
        get {
            self.willAccessValue(forKey: "fromMe")
            let result: Int = self.primitiveValue(forKey: "fromMe") as! Int
            self.didAccessValue(forKey: "fromMe")
            return result != 0
        }
        set(fromMe) {
            self.willChangeValue(forKey: "fromMe")
            self.setPrimitiveValue(fromMe, forKey: "fromMe")
            self.didChangeValue(forKey: "fromMe")
        }
    }
    
    var header: String {
        get {
            var format: DateFormatter? = nil
            if format == nil {
                format = DateFormatter()
                format!.dateFormat = "MMM dd, HH:mm"
            }
            let name: String = self.fromMe ? "Me" : (self.source).name
            return "\(name) at \(format!.string(from: self.time))"
        }
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.setPrimitiveValue(Date().timeIntervalSinceReferenceDate, forKey: "timeSinceReferenceDate")
    }
}
