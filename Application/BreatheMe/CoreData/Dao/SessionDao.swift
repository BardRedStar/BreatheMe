//
//  Session+CoreDataDao.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData

/// A data access object class to manipulate sessions in CoreData
class SessionDao {

    // MARK: - Data methods

    /// Inserts new session with `startDate` and `endDate`
    func insert(startDate: Date, endDate: Date?, context: NSManagedObjectContext) -> Session? {
        guard let session = NSEntityDescription.insertNewObject(forEntityName: Session.entityName, into: context) as? Session else {
            return nil
        }

        session.startDate = startDate
        session.endDate = endDate
        return session
    }

    /// Gets sessions by `limit` with `offset`
    func getSessions(limit: Int = 0, offset: Int = 0, context: NSManagedObjectContext) throws -> [Session] {
        let request: NSFetchRequest<Session> = Session.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Session.startDate), ascending: false)]
        request.fetchLimit = limit
        request.fetchOffset = offset
        return try context.fetch(request)
    }
}
