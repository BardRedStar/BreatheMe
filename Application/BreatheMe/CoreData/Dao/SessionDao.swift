//
//  Session+CoreDataDao.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData

class SessionDao {

    func insert(startDate: Date, endDate: Date, context: NSManagedObjectContext) {
        guard let session = NSEntityDescription.insertNewObject(forEntityName: Session.entityName, into: context) as? Session else {
            return
        }

        session.startDate = startDate
        session.endDate = endDate
    }

    func getSessions(limit: Int = 0, offset: Int = 0, context: NSManagedObjectContext) throws -> [Session] {
        let request: NSFetchRequest<Session> = Session.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Session.startDate), ascending: false)]
        request.fetchLimit = limit
        request.fetchOffset = offset
        return try context.fetch(request)
    }
}
