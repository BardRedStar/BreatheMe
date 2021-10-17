//
//  Record+CoreDataDao.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData

class RecordDao {
    
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

    func getRecordsForSession(session: Session, context: NSManagedObjectContext) throws -> [Record] {
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Record.session), session)
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Record.startDate), ascending: false)]

        return try context.fetch(request)
    }

}
