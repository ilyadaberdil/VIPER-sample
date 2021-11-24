//
//  NotificationsContracts.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

// MARK: - Interactor
protocol NotificationsInteractorProtocol: AnyObject {
    func load()
}

enum NotificationsInteractorOutput {
    case setLoading(_ isLoading: Bool)
    case showNotifications(_ notificationList: [Notification])
    case showStatusFilters(_ filters: [StatusFilter])
    case showError(_ error: Error)
}

protocol NotificationsInteractorDelegate: AnyObject {
    func handleOutput(_ output: NotificationsInteractorOutput)
}

// MARK: - Presenter
protocol NotificationsPresenterProtocol: AnyObject {
    func loadNotifications()
    func selectNotification(at index: Int)
    func selectStatusFilter(at index: Int)
    func selectDateFilter(_ date: Date)
}

enum NotificationsPresenterOutput: Equatable {
    case setLoading(_ isLoading: Bool)
    case setData(_ dataList: [NotificationCellViewModel])
    case showStatusFilters(_ filters: [String])
    case setStatusFilterPlaceholder(_ placeholder: String)
    case setDateFilterPlaceholder(_ placeholder: String)
    case setHeader(_ text: String?)
    case reloadData
}

// MARK: - View
protocol NotificationsViewProtocol: AnyObject {
    func handleOutput(_ output: NotificationsPresenterOutput)
}

// MARK: - Router
protocol NotificationsRouterProcotol: AnyObject {
    func proceedToDetail(_ notification: Notification)
    func showError(_ okButtonPressed: (() -> Void)?)
}
