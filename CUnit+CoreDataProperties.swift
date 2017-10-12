//
//  CUnit+CoreDataProperties.swift
//  CoreDataManyToMany
//
//  Created by Jatin Garg on 13/10/17.
//  Copyright © 2017 Jatin Garg. All rights reserved.
//
//

import Foundation
import CoreData


extension CUnit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CUnit> {
        return NSFetchRequest<CUnit>(entityName: "CUnit")
    }

    @NSManaged public var typeName: String?
    @NSManaged public var labelName: String?
    @NSManaged public var typeID: Int32
    @NSManaged public var labelID: Int32
    @NSManaged public var job: Int32
    @NSManaged public var floors: NSSet?

}

// MARK: Generated accessors for floors
extension CUnit {

    @objc(addFloorsObject:)
    @NSManaged public func addToFloors(_ value: CFloor)

    @objc(removeFloorsObject:)
    @NSManaged public func removeFromFloors(_ value: CFloor)

    @objc(addFloors:)
    @NSManaged public func addToFloors(_ values: NSSet)

    @objc(removeFloors:)
    @NSManaged public func removeFromFloors(_ values: NSSet)

}
