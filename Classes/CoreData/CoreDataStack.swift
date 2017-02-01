//
//  CoreDataStack.swift
//  TestTask
//
//  Created by Amaury Vidal on 31/01/2017.
//
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // Can't init because it is singleton
    private init() {}
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error._userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    } 
}
