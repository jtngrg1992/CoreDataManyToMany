//
//  CBuilding+CoreDataProperties.swift
//  CoreDataManyToMany
//
//  Created by Jatin Garg on 13/10/17.
//  Copyright © 2017 Jatin Garg. All rights reserved.
//
//

import Foundation
import CoreData


extension CBuilding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CBuilding> {
        return NSFetchRequest<CBuilding>(entityName: "CBuilding")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var job: Int32
    @NSManaged public var floors: NSSet?

}

// MARK: Generated accessors for floors
extension CBuilding {

    @objc(addFloorsObject:)
    @NSManaged public func addToFloors(_ value: CFloor)

    @objc(removeFloorsObject:)
    @NSManaged public func removeFromFloors(_ value: CFloor)

    @objc(addFloors:)
    @NSManaged public func addToFloors(_ values: NSSet)

    @objc(removeFloors:)
    @NSManaged public func removeFromFloors(_ values: NSSet)

}
