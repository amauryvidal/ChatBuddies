import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow!
    var navigationController: UINavigationController!
    var repository: Repository!
    lazy var context: NSManagedObjectContext = {
        let result = NSManagedObjectContext()
        result.persistentStoreCoordinator = self.coordinator
        return result
    }()
    
    lazy var model: NSManagedObjectModel = {
            var path: String = Bundle.main.path(forResource: "Model", ofType: "mom")!
            return NSManagedObjectModel(contentsOf: URL(fileURLWithPath: path))!
    }()
    
    lazy var coordinator: NSPersistentStoreCoordinator = {
        var storeURL: URL =  URL(fileURLWithPath: self.applicationDocumentsDirectory).appendingPathComponent("Store.sqlite")
        var error: NSError? = nil
        let result = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        try! result.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        return result
    }()
    
    lazy var applicationDocumentsDirectory: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    
    func findAllOfEntity(_ entityName: String) -> [AnyObject] {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let description = NSEntityDescription.entity(forEntityName: entityName, in: self.context)
        request.entity = description
        return try! self.context.fetch(request)
    }
    
    func addHardCodedBuddies() {
        if self.findBuddies().count > 0 {
            return
        }
        self.buddyWithName("Jacob")
        self.buddyWithName("Bonnie")
        self.buddyWithName("Matt")
        self.buddyWithName("Kelly")
        self.save()
    }
    
    func addSortDescriptors() {
        let desc: NSEntityDescription = (self.model).entitiesByName["Buddy"]!
        let prop: NSFetchedPropertyDescription = desc.propertiesByName["messages"] as! NSFetchedPropertyDescription
        let fetchRequest: NSFetchRequest = prop.fetchRequest!
        let sort: NSSortDescriptor = NSSortDescriptor(key: "timeSinceReferenceDate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
    }
    
    func entityForName(_ name: String) -> AnyObject {
        return NSEntityDescription.insertNewObject(forEntityName: name, into: self.context)
    }
    
    func save() {
        try! self.context.save()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.repository = Repository(delegate: self)
        self.repository.delegate = self
        let buddies: BuddiesController = BuddiesController(repository: self.repository)
        buddies.repository = self.repository
        self.addSortDescriptors()
        self.addHardCodedBuddies()
        self.navigationController = UINavigationController()
        self.navigationController.pushViewController(buddies, animated: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.save()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        /*
         Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
         */
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.save()
    }
    /**
     Returns the path to the application's Documents directory.
     */
    
    func buddyWithName(_ name: String) -> Buddy {
        let result: Buddy = self.entityForName("Buddy") as! Buddy
        result.name = name
        return result
    }
    
    func findBuddies() -> [AnyObject] {
        return self.findAllOfEntity("Buddy")
    }
    /**
     Returns the managed object context for the application.
     If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
     */
    /**
     Returns the managed object model for the application.
     If the model doesn't already exist, it is created from the application's model.
     */
    /**
     Returns the persistent store coordinator for the application.
     If the coordinator doesn't already exist, it is created and the application's store added to it.
     */
}
