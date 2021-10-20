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

        // Create window
        window = UIWindow()
        window?.makeKeyAndVisible()

        // Set up nav bar appearance
        setNavbarTransparent()

        // Configure DI
        let database = Database()
        let dataManager = DataManager(database: database)
        let sessionDao = SessionDao()
        let recordDao = RecordDao()
        let sessionRepository = SessionRepository(database: database, sessionDao: sessionDao)
        let recordRepository = RecordRepository(database: database, recordDao: recordDao)
        let session = AppSession(dataManager: dataManager, sessionRepository: sessionRepository, recordRepository: recordRepository)

        // Setup and start routing
        appRouter = AppRouter(window: window!, session: session)
        appRouter.start()

        return true
    }

    // MARK: - UI Methods

    /// Sets navbar transparent along the whole app
    private func setNavbarTransparent() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }

}

