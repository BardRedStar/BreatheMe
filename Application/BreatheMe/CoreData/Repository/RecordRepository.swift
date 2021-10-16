//
//  RecordRepository.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import Foundation

class RecordRepository {

    let database: Database
    let recordDao: RecordDao

    init(database: Database, recordDao: RecordDao) {
        self.database = database
        self.recordDao = recordDao
    }

    func saveRecordWith(type: String, startDate: Date, endDate: Date, to session: Session, completion: (Result<Void, Error>) -> Void ) {
        do {
            recordDao.insert(type: type, startDate: startDate, endDate: endDate, session: session, context: database.context)
            try database.saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
