//
//  AppRouter.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit
import MessageUI

class AppRouter {

    let session: AppSession

    private var navigationController: UINavigationController?
    private weak var window: UIWindow?

    init(window: UIWindow, session: AppSession) {
        self.session = session
        self.window = window
    }

    func start() {
        runMain()
    }

    // MARK: - Routing

    private func runMain() {
        let viewModel = MainControllerViewModel(session: session)
        let controller = MainViewController.instantiate(viewModel: viewModel)

        controller.didTapSessions = { [weak self] in
            self?.runSessionsList()
        }

        setRootController(controller)
    }

    private func runSessionsList() {
        let viewModel = SessionListControllerViewModel(appSession: session)
        let controller = SessionListViewController.instantiate(viewModel: viewModel)

        controller.didSelectSession = { [weak self] session in
            self?.runRecordsListWith(session: session)
        }

        push(controller)
    }

    private func runRecordsListWith(session: Session) {
        let viewModel = RecordListControllerViewModel(appSession: self.session, session: session)
        let controller = RecordListViewController.instantiate(viewModel: viewModel)

        push(controller)
    }

    // MARK: - Helpers

    private func push(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }

    private func present(_ controller: UIViewController) {
        navigationController?.present(controller, animated: true, completion: nil)
    }

    private func setRootController(_ controller: UIViewController) {
        navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
    }
}
