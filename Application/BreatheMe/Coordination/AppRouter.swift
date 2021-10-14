//
//  AppRouter.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

class AppRouter {

    let session: AppSession

    private let navigationController = UINavigationController()
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

        setRootController(controller)
    }

    // MARK: - Helpers

    private func push(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }

    private func setRootController(_ controller: UIViewController) {
        window?.rootViewController = UINavigationController(rootViewController: controller)
    }
}
