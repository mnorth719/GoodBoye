//
//  CoreDataManager.swift
//  GoodBoye
//
//  Created by Matt  North on 4/25/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import Foundation
import CoreData

enum GBCoreDataErrorType: Int {
    case InvalidRequest
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "GBModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Error creating persistent store: \(error.localizedDescription)")
            }
        })
        
        return container
    }
}
