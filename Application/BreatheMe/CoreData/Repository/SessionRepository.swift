//
//  SessionRepository.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import Foundation

/// A repository class for loading sessions from database
class SessionRepository {
    // MARK: - Properties

    let database: Database
    private let sessionDao: SessionDao

    // MARK: - Initialization

    init(database: Database, sessionDao: SessionDao) {
        self.database = database
        self.sessionDao = sessionDao
    }

    // MARK: - Data Methods

    /// Loads sessions by batches with `limit` size and `offset`
    func getSessions(limit: Int = 0, offset: Int = 0, completion: (Result<[Session], Error>) -> Void) {
        do {
            let sessions = try sessionDao.getSessions(limit: limit, offset: offset, context: database.context)
            completion(.success(sessions))
        } catch {
            completion(.failure(error))
        }
    }

    /// Creates session object with `startDate` and `endDate`. If `endDate` is `nil`, it means that session isn't over yet
    func createSessionWith(startDate: Date, endDate: Date?, completion: (Result<Session, Error>) -> Void ) {

        guard let session = sessionDao.insert(startDate: startDate, endDate: endDate, context: database.context) else {
            completion(.failure(CoreDataError.createNewObject("Couldn't create new session")))
            return
        }

        completion(.success(session))
    }
}
