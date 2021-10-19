//
//  RecordListControllerViewModel.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 18.10.2021.
//

import Foundation

/// A view model class for record list screen
class RecordListControllerViewModel {

    // MARK: - Output

    var didDataUpdate: (() -> Void)?
    var didError: ((Error) -> Void)?

    // MARK: - Properties

    private let appSession: AppSession
    private let session: Session

    private let records: [Record]

    /// Number of records in current session
    var numberOfRecords: Int {
        session.record?.count ?? 0
    }

    // MARK: - Initialization

    init(appSession: AppSession, session: Session) {
        self.appSession = appSession
        self.session = session
        records = session.record?.allObjects.compactMap { $0 as? Record }.sorted(by: { $0.startDate < $1.startDate }) ?? []
    }

    // MARK: - Data Methods

    /// Loads data
    func loadData() {
        didDataUpdate?()
    }

    /// Retrieves record UI model for `position`
    func recordViewModelFor(position: Int) -> RecordListCell.ViewModel? {
        let record = records[position]

        let type = BreatheStage(rawValue: record.type)?.presentationString ?? "Unknown"
        let duration = DateTimeHelper.formattedDuration(from: record.startDate, to: record.endDate ?? Date())
        return RecordListCell.ViewModel(type: type, duration: duration)
    }
}
