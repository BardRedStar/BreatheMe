//
//  AppDelegate.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRouter: AppRouter!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()

        setNavbarTransparent()

        let dataManager = DataManager()
        let session = AppSession(dataManager: dataManager)

        appRouter = AppRouter(window: window!, session: session)
        appRouter.start()

        return true
    }

    // MARK: - UI Methods

    private func setNavbarTransparent() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }

}

