//
//  CFloor+CoreDataProperties.swift
//  CoreDataManyToMany
//
//  Created by Jatin Garg on 13/10/17.
//  Copyright © 2017 Jatin Garg. All rights reserved.
//
//

import Foundation
import CoreData


extension CFloor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CFloor> {
        return NSFetchRequest<CFloor>(entityName: "CFloor")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var job: Int32
    @NSManaged public var building: CBuilding?
    @NSManaged public var units: NSSet?

}

// MARK: Generated accessors for units
extension CFloor {

    @objc(addUnitsObject:)
    @NSManaged public func addToUnits(_ value: CUnit)

    @objc(removeUnitsObject:)
    @NSManaged public func removeFromUnits(_ value: CUnit)

    @objc(addUnits:)
    @NSManaged public func addToUnits(_ values: NSSet)

    @objc(removeUnits:)
    @NSManaged public func removeFromUnits(_ values: NSSet)

}
