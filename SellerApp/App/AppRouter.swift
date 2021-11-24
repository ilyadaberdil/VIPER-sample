//
//  AppRouter.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation
import UIKit

final class AppRouter {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let childRouter: Router
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        childRouter = NotificationsRouter(navigationController: navigationController)
    }
}

extension AppRouter: Router {
    func start() {
        window.rootViewController = navigationController
        childRouter.start()
        window.makeKeyAndVisible()
    }
}
