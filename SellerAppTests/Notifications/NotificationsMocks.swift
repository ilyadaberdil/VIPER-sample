//
//  NotificationsMocks.swift
//  SellerAppTests
//
//  Created by Berdil Ilyada Karacam on 23.11.2021.
//

import UIKit
@testable import SellerApp

// MARK: - View
final class MockNotificationView: NotificationsViewProtocol {
    func handleOutput(_ output: NotificationsPresenterOutput) {
        outputs.append(output)
    }
    
    var presenter: NotificationsPresenterProtocol!
    private(set) var outputs: [NotificationsPresenterOutput] = .emptyValue
    
    func viewDidLoad() {
        presenter.loadNotifications()
    }
    
    func notificationTapped(at index: Int) {
        presenter.selectNotification(at: index)
    }
}

// MARK: - Router
final class MockNotificationsRouter: NotificationsRouterProcotol {
    
    private(set) var isProceedToDetail: Bool = false
    func proceedToDetail(_ notification: SellerApp.Notification) {
        isProceedToDetail = true
    }
    
    private(set) var isShowError: Bool = false
    func showError(_ okButtonPressed: (() -> Void)?) {
        isShowError = true
    }
}

// MARK: - Service
final class MockNotificationService: ServiceProtocol {
    
    var mockNotificationResponse: SellerApp.NotificationResponse?
    
    func execute<T>(_ type: T.Type, model: HttpModel, completionHandler: @escaping APICompletionHandler<T>) where T : Decodable {
        if let response = mockNotificationResponse {
            completionHandler(.success(response as! T))
        } else {
            completionHandler(.failure(APIError.generic))
        }
    }
}

// MARK: - Entity
extension NotificationResponse {
    static let mockResponse = NotificationResponse(sellerList: [Notification.init(title: "Sample",
                                                                                  preDescription: "Description",
                                                                                  date: "13/07/1995",
                                                                                  isRead: false)])
}
