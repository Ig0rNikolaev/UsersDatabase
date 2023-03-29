//
//  CoreDataManager.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import CoreData

final class CoreDataManager {

    //MARK: - Outlets

    static let shared = CoreDataManager()
    lazy var managedContext: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    //: MARK: - Init

    private init() {}
    
    //: MARK: - Setups

    func entityForName(userName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: userName, in: managedContext) ?? NSEntityDescription()
    }

    func fetchedResultController(entity: String, sortName: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchedResult = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let sortDescriptor = NSSortDescriptor(key: sortName, ascending: true)
        fetchedResult.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchedResult,
                                                                 managedObjectContext: CoreDataManager.shared.managedContext,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        return fetchedResultController
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
