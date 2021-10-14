//
//  Session+CoreDataDao.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData

class SessionDao {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func insert(startDate: Date, endDate: Date, records: NSSet) {
        guard let session = NSEntityDescription.insertNewObject(forEntityName: Session.entityName, into: context) as? Session else {
            return
        }

        session.startDate = startDate
        session.endDate = endDate
        session.record = records
    }

}
