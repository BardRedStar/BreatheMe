//
//  AppRouter.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit
import MessageUI

/// A main router class, which is responsible for navigation
class AppRouter {

    // MARK: - Properties

    let appSession: AppSession

    private var navigationController: UINavigationController?
    private weak var window: UIWindow?

    // MARK: - Initializaion

    init(window: UIWindow, session: AppSession) {
        self.appSession = session
        self.window = window
    }

    /// Start point of the routing
    func start() {
        runMain()
    }

    // MARK: - Routing

    private func runMain() {
        let viewModel = MainControllerViewModel(session: appSession)
        let controller = MainViewController.instantiate(viewModel: viewModel)

        controller.didTapSessions = { [weak self] in
            self?.runSessionsList()
        }

        setRootController(controller)
    }

    private func runSessionsList() {
        let viewModel = SessionListControllerViewModel(appSession: appSession)
        let controller = SessionListViewController.instantiate(viewModel: viewModel)

        controller.didSelectSession = { [weak self] session in
            self?.runRecordsListWith(session: session)
        }

        push(controller)
    }

    private func runRecordsListWith(session: Session) {
        let viewModel = RecordListControllerViewModel(appSession: self.appSession, session: session)
        let controller = RecordListViewController.instantiate(viewModel: viewModel)

        push(controller)
    }

    // MARK: - Helpers

    /// Pushes controller onto navigation stack
    private func push(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }

    /// Presents controller modally
    private func present(_ controller: UIViewController) {
        navigationController?.present(controller, animated: true, completion: nil)
    }

    /// Sets controller as root
    private func setRootController(_ controller: UIViewController) {
        navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
    }
}
