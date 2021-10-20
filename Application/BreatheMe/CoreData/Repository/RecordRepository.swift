//
//  RecordRepository.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import Foundation

/// A repository class for loading records from database
class RecordRepository {
    // MARK: - Properties

    private let database: Database
    private let recordDao: RecordDao

    // MARK: - Initialization

    init(database: Database, recordDao: RecordDao) {
        self.database = database
        self.recordDao = recordDao
    }

    // MARK: - Data Methods

    /// Creates record with `type` string, `startDate` and `endDate` and attaches it to `session`.
    /// If `endDate` is `nil`, it means that record (action) is not finished yet
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
            completion(.failure(CoreDataError.createNewObject("Error-Cant-Create-Record".localized())))
            return
        }
        completion(.success(record))
    }
}
