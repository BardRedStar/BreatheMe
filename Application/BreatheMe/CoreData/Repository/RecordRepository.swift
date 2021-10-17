//
//  RecordRepository.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import Foundation

class RecordRepository {

    private let database: Database
    private let recordDao: RecordDao

    init(database: Database, recordDao: RecordDao) {
        self.database = database
        self.recordDao = recordDao
    }

    func createRecordWith(type: String,
                          startDate: Date,
                          endDate: Date?,
                          attachTo session: Session,
                          completion: (Result<Record, Error>) -> Void) {

        guard let record = recordDao.insert(type: type,
                                            startDate: startDate,
                                            endDate: endDate,
                                            session: session,
                                            context: database.context) else {
            completion(.failure(CoreDataError.createNewObject("Couldn't create new record")))
            return
        }
        completion(.success(record))
    }
}
