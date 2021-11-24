//
//  NotificationsRouter.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import UIKit

final class NotificationsRouter {
    
    private let navigationController: UINavigationController
    
    private weak var notificationsViewController: UIViewController?    // if needed
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Router
extension NotificationsRouter: Router {
    func start() {
        let viewController = NotificationsBuilder.initModule(router: self)
        navigationController.pushViewController(viewController, animated: true)
        notificationsViewController = viewController    // if needed
    }
}

// MARK: - NotificationsRouterProcotol
extension NotificationsRouter: NotificationsRouterProcotol {
    func proceedToDetail(_ notification: Notification) {
        let vc = UIViewController()
        vc.title = notification.title
        vc.view.backgroundColor = .red
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showError(_ okButtonPressed: (() -> Void)?) {
        let alert = UIAlertController(title: "Error Occurred", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            okButtonPressed?()
        }))
        navigationController.present(alert, animated: true, completion: nil)
    }
}
