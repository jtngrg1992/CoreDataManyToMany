//
//  CoreDataManager.swift
//  CoreDataManyToMany
//
//  Created by Jatin Garg on 12/10/17.
//  Copyright © 2017 Jatin Garg. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    typealias completion = ()->()
    fileprivate let modelName: String
    fileprivate let completion: completion
    
    init(modelName: String, completion: @escaping completion){
        self.modelName = modelName
        self.completion = completion
        setupStack()
        
        setupNotificationHandling()
    }
    
    private func setupNotificationHandling(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: Notification.Name.UIApplicationWillTerminate, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    public private(set) lazy var mainMOC: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        moc.parent = self.privateMOC
        return moc
    }()
    
    fileprivate lazy var privateMOC: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        return moc
    }()
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let url = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }
        
        let mom = NSManagedObjectModel(contentsOf: url)
        return mom
    }()
    
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let mom = self.managedObjectModel else { return nil }
        
        let psc =  NSPersistentStoreCoordinator(managedObjectModel: mom)
        return psc
    }()
    
    fileprivate var persistentStoreURL: URL{
        let storeName = "\(modelName).sqlite"
        let fileManager = FileManager.default
        let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(storeName)
    }
    
    @objc func saveChanges(){
        self.mainMOC.performAndWait {
            do{
                if self.mainMOC.hasChanges{
                    try self.mainMOC.save()
                }
            }catch{
                let saveError = error as NSError
                print("unable to save changes of main managed object context")
                print("save error: \(saveError.localizedDescription)")
            }
        }
        
        privateMOC.perform {
            do{
                if self.privateMOC.hasChanges{
                    try self.privateMOC.save()
                }
            }catch{
                let saveError = error as NSError
                print("unable to save changes of private managed object context")
                print("save error: \(saveError.localizedDescription)")
            }
        }
    }
    
    func privateChildMoc()->NSManagedObjectContext{
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = mainMOC
        return moc
    }
    
    fileprivate func setupStack(){
        let _ = mainMOC.persistentStoreCoordinator
        DispatchQueue.global().async {
            self.addPersistentStore()
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
    
    fileprivate func addPersistentStore(){
        guard let persistentStore = persistentStoreCoordinator else { fatalError("Unable to initialize persistent store coordinator")}
        let persistentStoreurl  = self.persistentStoreURL
        do{
            let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
            try persistentStore.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreurl, options: options)
        }catch{
            let addPersistentStoreError = error as NSError
            
            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }
    }
}
