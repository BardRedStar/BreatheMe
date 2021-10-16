//
//  Session+CoreDataClass.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject, Identifiable {}

extension Session {
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date?
    @NSManaged var record: NSSet

    static var entityName = "Session"

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: Self.entityName)
    }
}
