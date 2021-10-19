//
//  SessionListControllerViewModel.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import Foundation

/// A view model class for session list screen
class SessionListControllerViewModel {
    // MARK: - Definitions

    /// Constants
    enum Constants {
        /// Number of sessions per page
        static let sessionsPerPage: Int = 20
    }

    // MARK: - Output

    var didUpdateData: (() -> Void)?
    var didError: ((Error) -> Void)?
    var didExportSessions: ((URL) -> Void)?

    // MARK: - Properties

    let appSession: AppSession

    private let fileIOManager = FileIOManager()

    private var breatheSessions: [String: [Session]] = [:]
    private var sectionDates: [String] = []

    /// Pagination

    /// Current content page
    private var page: Int = 0
    /// A flag whether to load a new batch of sessions or not
    var isReadyForLoading: Bool = true

    /// Number of sections (sessions grouped by days)
    var numberOfSections: Int {
        sectionDates.count
    }

    // MARK: - Initialization

    init(appSession: AppSession) {
        self.appSession = appSession
    }

    // MARK: - Data Methods

    /// Loads a new page of sessions
    func loadData() {
        if !isReadyForLoading {
            return
        }

        isReadyForLoading = false

        let limit = Constants.sessionsPerPage
        appSession.sessionRepository.getSessions(limit: limit, offset: page * limit) { [weak self] result in
            guard let self = self else { return }

            self.isReadyForLoading = true

            switch result {
            case let .success(sessions):

                if sessions.isEmpty {
                    isReadyForLoading = false
                    return
                }

                self.appendSessions(sessions)

                self.page += 1

                self.didUpdateData?()

            case let .failure(error):
                self.didError?(error)
            }
        }
    }

    /// Retrieves a UI model for session in` `section` at `position`
    func sessionViewModelFor(section: Int, position: Int) -> SessionListCell.ViewModel? {
        guard let session = breatheSessions[sectionDates[section]]?[position] else { return nil }
        let records = session.record?.allObjects.compactMap { $0 as? Record } ?? []
        let inhales = records.reduce(0, { $0 + ($1.type == BreatheStage.inhale.rawValue ? 1 : 0)})
        let exhales = records.reduce(0, { $0 + ($1.type == BreatheStage.exhale.rawValue ? 1 : 0)})
        return SessionListCell.ViewModel(inhales: inhales,
                                         exhales: exhales,
                                         startDate: DateTimeHelper.formattedTimeFromDate(session.startDate),
                                         endDate: session.endDate.flatMap { DateTimeHelper.formattedTimeFromDate($0) } ?? "...")
    }

    /// Gets string representation of date for `section`
    func dateForSection(_ section: Int) -> String {
        sectionDates[section]
    }

    /// Gets number of sessions in `section`
    func numberOfSessionsFor(section: Int) -> Int {
        breatheSessions[sectionDates[section]]?.count ?? 0
    }

    /// Gets particular session in `section` at `position`
    func sessionFor(section: Int, position: Int) -> Session? {
        breatheSessions[sectionDates[section]]?[position]
    }

    /// Creates a temp file and dumps all sessions batch by batch
    func prepareSessionsForShare() {
        let file = fileIOManager.createFileForShare()
        loadAndWriteSessions(to: file, page: 0)
    }

    /// Recursively loads sessions by pages and write them to `file`
    private func loadAndWriteSessions(to file: URL, page: Int) {
        appSession.sessionRepository.getSessions(limit: Constants.sessionsPerPage,
                                                 offset: page * Constants.sessionsPerPage) { [weak self] result in
            switch result {
            case let .success(batch):

                if batch.isEmpty {
                    self?.fileIOManager.commmit()
                    self?.didExportSessions?(file)
                    return
                }

                let text = batch
                    .map {
                        let startDateString = DateTimeHelper.formattedTimeFromDate($0.startDate)
                        let endDateString = $0.endDate.flatMap { DateTimeHelper.formattedTimeFromDate($0) } ?? "..."
                        let sessionString = "\(startDateString) - \(endDateString)"
                        let recordsString = $0.record?.allObjects
                            .map { $0 as! Record }
                            .sorted { $0.startDate < $1.startDate }
                            .map {
                                let type = BreatheStage(rawValue: $0.type)?.presentationString ?? "Unknown"
                                let duration = DateTimeHelper.formattedDuration(from: $0.startDate, to: $0.endDate ?? Date())
                                return "\(type) - \(duration)"
                            }
                            .joined(separator: "\n") ?? ""
                        return "[\n\(sessionString)\n\(recordsString)\n]\n"
                    }
                    .joined(separator: "\n")

                do {
                    try self?.fileIOManager.appendText(text: text, to: file)
                } catch {
                    self?.fileIOManager.commmit()
                    self?.didError?(error)
                }

                self?.loadAndWriteSessions(to: file, page: page + 1)

            case let .failure(error):
                self?.didError?(error)
                self?.fileIOManager.commmit()
            }
        }
    }

    /// Appends new sessions to cached data arrays
    private func appendSessions(_ sessions: [Session]) {
        sessions.forEach {
            let date = DateTimeHelper.formattedDayFromDate($0.startDate)
            if !sectionDates.contains(date) {
                sectionDates.append(date)
            }
            breatheSessions[date, default: []].append($0)
        }
    }
}
