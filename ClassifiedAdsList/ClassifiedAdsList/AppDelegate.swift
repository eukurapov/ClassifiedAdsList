//
//  AppDelegate.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController

        appCoordinator = AppCoordinator(navigationController: rootViewController)
        appCoordinator?.start()

        window?.makeKeyAndVisible()

        return true
    }

}

