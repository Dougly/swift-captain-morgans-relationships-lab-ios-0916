//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Douglas Galante on 11/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    
    
    var pirates: [Pirate] = []
    var ships: [Ship] = []
    var engine: [Engine] = []
    
    
    
    // MARK: - CoreData
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CaptainMorgan")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
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
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Pirate>(entityName: "Pirate")
        
        do {
            pirates = try context.fetch(fetchRequest)
        } catch {
            print("could not fetch data")
        }
    }
    
    func generateTestData() {
        let context = persistentContainer.viewContext
        
        for i in 1...20 {
            //generate pirate
            let pirateEntity = Pirate(context: context)
            pirateEntity.name = "Pirate #\(i)"
            
            //create 10 ships for the pirate
            for i in 1...10 {
                let shipEntity = Ship(context: context)
                shipEntity.name = "\(pirateEntity.name!)'s Ship #\(i)"
                
                //create engine for each ship
                let engineEntity = Engine(context: context)
                let randomEngine = EngineType(rawValue: Int(arc4random_uniform(4)))
                if let randomEngine = randomEngine {
                    engineEntity.type = randomEngine.stringValue
                    shipEntity.engines = engineEntity
                }
                
                pirateEntity.addToShips(shipEntity)
            }
        }
    }
}

// MARK: - EngineType Enum

enum EngineType: Int {
    case sail, oars, gas, nuclear
    
    var stringValue: String {
        switch self {
        case .sail: return "Sail"
        case .gas: return "Gas"
        case .nuclear: return "Nuclear"
        case .oars: return "Oars"
        }
    }
}
