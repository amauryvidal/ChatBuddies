//
//  MessagesViewModel.swift
//  TestTask
//
//  Created by Amaury Vidal on 31/01/2017.
//
//

import Foundation

protocol ChatViewModelProtocol {
    var nbMessages: Int {get}
    var lastMessageContent: String? {get}
    func message(at index: Int) -> Message?
    func addMessage(text: String, fromMe: Bool)
}

struct ChatViewModel: ChatViewModelProtocol {
    private(set) var buddy: Buddy
    
    private var messages: [Message] {
        return buddy.messages
    }
    
    var nbMessages: Int {
        return buddy.messages.count
    }
    
    var lastMessageContent: String? {
        return messages.last?.text
    }
    
    func message(at index: Int) -> Message? {
        guard index < nbMessages else {
            return nil
        }
        return messages[index]
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
