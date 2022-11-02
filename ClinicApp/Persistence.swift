//
//  Persistence.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 10/18/22.
//

import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    //An Initializer to load Core Data, optionally able to us an in-memory store
    // The in-memory store part of that code is important, because when you configure Core Data to save information into memory rather than disk it means all the changes you make get thrown away when your program ends.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ClinicApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
    
    
}

// Resources:

//https://www.hackingwithswift.com/quick-start/swiftui/how-to-configure-core-data-to-work-with-swiftui
