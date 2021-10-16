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

    func insert(startDate: Date, endDate: Date) {
        guard let session = NSEntityDescription.insertNewObject(forEntityName: Session.entityName, into: context) as? Session else {
            return
        }

        session.startDate = startDate
        session.endDate = endDate
    }

    func getSessions(context: NSManagedObjectContext) throws -> [Session] {
        let request: NSFetchRequest<Session> = Session.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Session.startDate), ascending: false)]
        
        return try context.fetch(request)
    }
}
