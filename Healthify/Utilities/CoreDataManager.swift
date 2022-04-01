//
//  CoreDataManager.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 29/03/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    init() {
    persistentContainer = NSPersistentContainer(name: "Healthify")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error  {
                fatalError("Unable to initialize\(error)")
                
            }

        }
    }
    
    /// Save data to database
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    ///Delete data from database
    func delete() {
      
        let request: NSFetchRequest<Step> = Step.fetchRequest()
        // Perform the fetch request
        do {
        let objects = try viewContext.fetch(request)
            // Delete the objects
            for object in objects {
                viewContext.delete(object)
            
        }
        }
        catch {
            
        }
       
      save()
    }
    
    /// Fetch details from database
    /// - Returns: Step dta for current month
    func getAllDataForCurrentMonth() -> [Step]{
        let request: NSFetchRequest<Step> = Step.fetchRequest()
      let predicate = NSPredicate(format: "month ==  %i", Date().get(.month))
       request.predicate = predicate
        do {
         return  try viewContext.fetch(request)
        }
        catch {
            return []
        }
        
    }
}
