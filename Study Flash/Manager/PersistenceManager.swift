//
//  PersistantManager.swift
//  Study Flash
//
//  Created by Alex Cheung on 31/10/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserInfoModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Successfully")
            } catch {
             
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
