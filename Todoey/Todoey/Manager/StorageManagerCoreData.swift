//
//  StorageManagerCoreData.swift
//  Todoey
//
//  Created by Дария Григорьева on 06.12.2022.
//

import Foundation
import CoreData

class StorageManagerCoreData {
    
    static let shared = StorageManagerCoreData()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Items")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchItems() -> [ItemCoreData] {
        let fetchRequest = ItemCoreData.fetchRequest()
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            return tasks
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func createItem(_ title: String) -> ItemCoreData {
        let task = ItemCoreData(context: viewContext)
        task.title = title
        task.done = false
        saveContext()
        return task
    }
    
    func update() {
        saveContext()
    }
    
    func delete(_ task: ItemCoreData) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    private func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
