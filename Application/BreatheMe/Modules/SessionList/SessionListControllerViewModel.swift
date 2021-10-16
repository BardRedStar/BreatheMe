//
//  SessionListControllerViewModel.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import Foundation

class SessionListControllerViewModel {
    // MARK: - Definitions

    enum Constants {
        static let sessionsPerPage: Int = 20
    }

    // MARK: - Output

    var didDataUpdate: (() -> Void)?

    // MARK: - Properties


    let session: AppSession

    private var breatheSessions: [String: [Session]] = [:]
    private var sectionDates: [String] = []

    private var page: Int = 0

    var numberOfSections: Int {
        sectionDates.count
    }

    // MARK: - Initialization

    init(session: AppSession) {
        self.session = session
    }

    // MARK: - Data Methods

    func loadData() {
        
    }

    func sessionViewModelFor(section: Int, position: Int) -> SessionListCell.ViewModel? {
        guard let session = breatheSessions[sectionDates[section]]?[position] else { return nil }
        session.record?.reduce(0, {})
        return SessionListCell.ViewModel(inhales: session.record.reduce(0, { $0 + ($1.type == BreatheStage.inhale.rawValue  ? 1 : 0)}),
                                         exhales: session.record.reduce(0, { $0 + ($1.type == BreatheStage.exhale.rawValue ? 1 : 0)}),
                                         startDate: session.startDate,
                                         endDate: session.endDate)
    }

    func dateForSection(_ section: Int) {
        
    }

    func numberOfSessionsFor(section: Int) -> Int {
        breatheSessions[sectionDates[section]]?.count ?? 0
    }
}
