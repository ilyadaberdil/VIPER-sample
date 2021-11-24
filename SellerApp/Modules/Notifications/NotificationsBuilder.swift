//
//  NotificationsBuilder.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

final class NotificationsBuilder {
    
    static func initModule(router: NotificationsRouterProcotol) -> NotificationsViewController {
        let viewController = NotificationsViewController()
        let interactor = NotificationsInteractor()
        let presenter = NotificationsPresenter(view: viewController,
                                               interactor: interactor,
                                               router: router)
        interactor.delegate = presenter
        viewController.presenter = presenter
        
        return viewController
    }
}
