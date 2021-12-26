//
//  SharedData.swift
//  Stickiz
//
//  Created by Jeremy Endratno on 12/26/21.
//

import UIKit
import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Stickiz")
        storeURL = storeURL?.appendingPathComponent("Stickiz.sqlite")
        return storeURL!
    }

}
