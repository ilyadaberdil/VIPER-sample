//
//  NotificationsPresenter.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

final class NotificationsPresenter {
    
    private var notificationList: [Notification] = .emptyValue
    private var presentedNotificationList: [Notification] = .emptyValue {
        didSet {
            let presentations = presentedNotificationList.map { NotificationCellViewModel(model: $0) }
            let headerText = presentations.isEmpty ? nil : "\(presentations.count) Adet Bildirim"
            view?.handleOutput(.setHeader(headerText))
            view?.handleOutput(.setData(presentations))
            view?.handleOutput(.reloadData)
        }
    }
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    private var statusFilters: [StatusFilter] = .emptyValue
    private var selectedStatusFilter: StatusFilter? {
        didSet {
            presentedNotificationList = getFilteredNotifications()
            view?.handleOutput(.setStatusFilterPlaceholder(selectedStatusFilter?.rawValue ?? .emptyValue))
        }
    }

    private var selectedDateFilter: String? {
        didSet {
            presentedNotificationList = getFilteredNotifications()
            view?.handleOutput(.setDateFilterPlaceholder(selectedDateFilter ?? .emptyValue))
        }
    }
    
    private weak var view: NotificationsViewProtocol?
    private let interactor: NotificationsInteractorProtocol
    private let router: NotificationsRouterProcotol
    
    init(view: NotificationsViewProtocol,
         interactor: NotificationsInteractorProtocol,
         router: NotificationsRouterProcotol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Private
private extension NotificationsPresenter {
    func getFilteredNotifications() -> [Notification] {
        
        var filteredList = notificationList
        
        if let statusFilter = selectedStatusFilter {
            switch statusFilter {
            case .all:
                filteredList = notificationList
            case .read:
                filteredList = notificationList.filter { !$0.isRead }
            case .new:
                filteredList = notificationList.filter { $0.isRead }
            }
        }
        
        if let dateFilter = selectedDateFilter {
            filteredList = filteredList.filter { $0.date == dateFilter }
        }
        
        return filteredList
    }
}

// MARK: - NotificationsPresenterProtocol
extension NotificationsPresenter: NotificationsPresenterProtocol {
    func loadNotifications() {
        interactor.load()
    }
    
    func selectNotification(at index: Int) {
        guard index < notificationList.count else {
            return
        }
        router.proceedToDetail(notificationList[index])
    }
    
    func selectStatusFilter(at index: Int) {
        guard index < statusFilters.count else {
            return
        }
        selectedStatusFilter = statusFilters[index]
    }
    
    func selectDateFilter(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        selectedDateFilter = dateString
    }
}

// MARK: - NotificationsInteractorOutput
extension NotificationsPresenter: NotificationsInteractorDelegate {
    func handleOutput(_ output: NotificationsInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view?.handleOutput(.setLoading(isLoading))
        case .showNotifications(let notificationList):
            self.notificationList = notificationList
            presentedNotificationList = notificationList
        case .showStatusFilters(let statusFilters):
            self.statusFilters = statusFilters
            view?.handleOutput(.showStatusFilters(statusFilters.map { $0.rawValue }))
            view?.handleOutput(.setStatusFilterPlaceholder("Durum"))
        case .showError(let error):
            router.showError {
                print("Error dismissed: \(error)")
            }
        }
    }
}
