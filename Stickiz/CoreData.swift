//
//  CoreData.swift
//  Stickiz
//
//  Created by Jeremy Endratno on 12/26/21.
//

import Foundation
import CoreData
import UIKit

class StickCoreData {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func create(stick: StickModel) {
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Stick", in: managedObjectContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        managedObject.setValue(stick.id, forKey: "id")
        managedObject.setValue(stick.name, forKey: "name")
        managedObject.setValue(stick.created_at, forKey: "created_at")
        
        do { try managedObjectContext.save() }
        catch let error { print("Failed to save Stick \(error.localizedDescription)") }
    }
    
    func read() -> [StickModel] {
        var sticks: [StickModel] = []
        let managedObjectContext = appDelegate.persistentContainer.viewContext
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
    
    func update(stick: StickModel) {
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stick")
        fetchRequest.predicate = NSPredicate(format: "id = '\(stick.id)'")
        do { let result = try managedObjectContext.fetch(fetchRequest)
            let managedObject = result[0] as! NSManagedObject
            managedObject.setValue(stick.id, forKey: "id")
            managedObject.setValue(stick.name, forKey: "name")
            managedObject.setValue(stick.created_at, forKey: "created_at")
            try managedObjectContext.save()
        }
        catch let error { print("Failed to upload Stick \(error.localizedDescription)") }
    }
    
    func delete(id: UUID) {
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stick")
        fetchRequest.predicate = NSPredicate(format: "id = '\(id)'")
        do { let managedObject = try managedObjectContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedObjectContext.delete(managedObject)
        }
        catch let error { print("Failed to delete Stick \(error.localizedDescription)") }
    }
}

class StickDataCoreData {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func create(stickData: StickDataModel) {
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "StickData", in: managedObjectContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        managedObject.setValue(stickData.id, forKey: "id")
        managedObject.setValue(stickData.stick_id, forKey: "stick_id")
        managedObject.setValue(stickData.name, forKey: "name")
        managedObject.setValue(stickData.value, forKey: "value")
        managedObject.setValue(stickData.created_at, forKey: "created_at")
        
        do { try managedObjectContext.save() }
        catch let error { print("Failed to save Stick \(error.localizedDescription)") }
    }
    
    func read() -> [StickDataModel] {
        var stickDatas: [StickDataModel] = []
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StickData")
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
    
    func readByStickID(stick_id: UUID) -> [StickDataModel] {
        var stickDatas: [StickDataModel] = []
        let managedObjectContext = appDelegate.persistentContainer.viewContext
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
    
    func update(stickData: StickDataModel) {
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StickData")
        fetchRequest.predicate = NSPredicate(format: "id = '\(stickData.id)'")
        do { let result = try managedObjectContext.fetch(fetchRequest)
            let managedObject = result[0] as! NSManagedObject
            managedObject.setValue(stickData.id, forKey: "id")
            managedObject.setValue(stickData.stick_id, forKey: "stick_id")
            managedObject.setValue(stickData.name, forKey: "name")
            managedObject.setValue(stickData.value, forKey: "value")
            managedObject.setValue(stickData.created_at, forKey: "created_at")
            try managedObjectContext.save()
        }
        catch let error { print("Failed to upload Stick \(error.localizedDescription)") }
    }
    
    func delete(id: UUID) {
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StickData")
        fetchRequest.predicate = NSPredicate(format: "id = '\(id)'")
        do { let managedObject = try managedObjectContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedObjectContext.delete(managedObject)
        }
        catch let error { print("Failed to delete Stick \(error.localizedDescription)") }
    }
}
