//
//  MainControllerViewModel.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

/// A view model for main screen
class MainControllerViewModel {

    // MARK: - Output

    var didError: ((Error) -> Void)?

    // MARK: - Properties

    let appSession: AppSession

    var isBreathing: Bool = false

    private var currentSession: Session?
    private var currentRecord: Record?

    // MARK: - Initialization

    init(session: AppSession) {
        self.appSession = session
    }

    // MARK: - Data methods

    /// Starts the new session
    func startNewSession() {
        appSession.sessionRepository.createSessionWith(startDate: Date(), endDate: nil) { [weak self] result in
            switch result {
            case let .success(session):
                self?.currentSession = session
                self?.appSession.dataManager.commitStorageChanges()
            case let .failure(error):
                self?.didError?(error)
            }
        }
    }

    /// Ends current session
    func endCurrentSession() {
        currentSession?.endDate = Date()
        currentRecord?.endDate = Date()

        appSession.dataManager.commitStorageChanges()
    }

    /// Processes new breathe stage. Finishes old if it exists.
    func processBreatheStage(_ stage: BreatheStage) {
        guard let session = currentSession else { return }
        currentRecord?.endDate = Date()

        appSession.recordRepository.createRecordWith(type: stage.rawValue, startDate: Date(), endDate: nil, attachTo: session) { [weak self] result in
            switch result {
            case let .success(record):
                self?.currentRecord = record
                self?.appSession.dataManager.commitStorageChanges()
            case let .failure(error):
                self?.didError?(error)
            }
        }
    }
}
