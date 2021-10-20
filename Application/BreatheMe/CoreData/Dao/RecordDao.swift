//
//  Record+CoreDataDao.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData

/// A data access object class for manipulating records in CoreData
class RecordDao {

    /// Inserts the new record object with `type` string, `startDate` and `endDate`, and attaches it to `session`
    func insert(type: String, startDate: Date, endDate: Date?, session: Session, context: NSManagedObjectContext) -> Record? {
        guard let record = NSEntityDescription.insertNewObject(forEntityName: Record.entityName, into: context) as? Record else {
            return nil
        }

        record.type = type
        record.startDate = startDate
        record.endDate = endDate
        record.session = session

        return record
    }
}
