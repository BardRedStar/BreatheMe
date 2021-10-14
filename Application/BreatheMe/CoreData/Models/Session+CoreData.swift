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
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var record: NSSet?
}
