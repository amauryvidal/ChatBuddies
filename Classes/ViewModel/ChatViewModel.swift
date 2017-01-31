//
//  MessagesViewModel.swift
//  TestTask
//
//  Created by Amaury Vidal on 31/01/2017.
//
//

import Foundation

struct ChatViewModel {
    var buddy: Buddy
    
    private var messages: [Message] {
        return buddy.messages
    }
    
    var nbMessages: Int {
        return buddy.messages.count
    }
    
    func message(at index: Int) -> Message? {
        guard index < nbMessages else {
            return nil
        }
        return messages[index]
    }
    
    var lastMessageContent: String? {
        return messages.last?.text
    }
    
    func addMessage(text: String, fromMe: Bool) {
        let context = CoreDataStack.shared.viewContext
        let msg = Message(context: context)
        msg.source = buddy
        msg.text = text
        msg.fromMe = fromMe
        context.refresh(buddy, mergeChanges: true)
        CoreDataStack.shared.saveContext()
    }
}
// let sortDescriptor = NSSortDescriptor(key: "timeSinceReferenceDate", ascending: true)

//func addSortDescriptors() {
//    let desc: NSEntityDescription = (self.model).entitiesByName["Buddy"]!
//    let prop: NSFetchedPropertyDescription = desc.propertiesByName["messages"] as! NSFetchedPropertyDescription
//    let fetchRequest: NSFetchRequest = prop.fetchRequest!
//    let sort: NSSortDescriptor = NSSortDescriptor(key: "timeSinceReferenceDate", ascending: true)
//    fetchRequest.sortDescriptors = [sort]
//}
