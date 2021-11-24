//
//  NotificationsInteractor.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

final class NotificationsInteractor: Interactor, NotificationsInteractorProtocol {
    
    weak var delegate: NotificationsInteractorDelegate?

    func load() {
        delegate?.handleOutput(.setLoading(true))
        delegate?.handleOutput(.showStatusFilters([.all, .new, .read]))
        let httpModel = HttpModel(path: MockAPI.path)
        service.execute(NotificationResponse.self, model: httpModel) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let notifications):
                self.delegate?.handleOutput(.showNotifications(notifications.sellerList))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        }
    }
}
