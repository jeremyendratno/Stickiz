//
//  KeyboardData.swift
//  Stickboard
//
//  Created by Jeremy Endratno on 12/26/21.
//

import Foundation
import CoreData

class KeyboardData {
    var persistentContainer: NSPersistentContainer = {
        let container = NSCustomPersistentContainer(name: "Stickiz")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func read() -> [StickModel] {
        var sticks: [StickModel] = []
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stick")
        do { let result = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach { stick in
                sticks.append(StickModel(id: stick.value(forKey: "id") as! UUID,
                                         name: stick.value(forKey: "name") as! String,
                                         created_at: stick.value(forKey: "created_at") as! Date))
            }
        } catch let error { print("Failed to read Stick \(error.localizedDescription)") }
        
        return sticks
    }
    
    func readByStickID(stick_id: UUID) -> [StickDataModel] {
        var stickDatas: [StickDataModel] = []
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StickData")
        fetchRequest.predicate = NSPredicate(format: "stick_id = '\(stick_id)'")
        do { let result = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach { stickData in
                stickDatas.append(StickDataModel(id: stickData.value(forKey: "id") as! UUID,
                                             stick_id: stickData.value(forKey: "stick_id") as! UUID,
                                             name: stickData.value(forKey: "name") as! String,
                                             value: stickData.value(forKey: "value") as! String,
                                             created_at: stickData.value(forKey: "created_at") as! Date))
            }
        } catch let error { print("Failed to read Stick \(error.localizedDescription)") }
        
        return stickDatas
    }
}


