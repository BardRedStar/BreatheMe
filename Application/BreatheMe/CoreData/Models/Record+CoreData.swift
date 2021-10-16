//
//  Record+CoreDataClass.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//
//

import Foundation
import CoreData

@objc(Record)
public class Record: NSManagedObject, Identifiable {}

extension Record {
    @NSManaged public var type: String
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date
    @NSManaged public var session: Session

    static var entityName = "Record"

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: Self.entityName)
    }
}
