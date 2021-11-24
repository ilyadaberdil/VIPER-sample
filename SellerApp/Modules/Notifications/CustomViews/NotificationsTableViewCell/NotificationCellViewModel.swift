//
//  NotificationCellViewModel.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

struct NotificationCellViewModel: Equatable {
    let title: String
    let description: String
    let date: String
    let infoBadge: InfoBadgeViewModel
    
    init(title: String, description: String, date: String, infoBadge: InfoBadgeViewModel) {
        self.title = title
        self.description = description
        self.date = date
        self.infoBadge = infoBadge
    }
}

extension NotificationCellViewModel {
    init(model: Notification) {
        title = model.title
        description = model.preDescription
        date = model.date
        infoBadge = model.isRead ?
            .init(info: "Yeni", style: .newInfoStyle) :
            .init(info: "Okundu", style: .readInfoStyle)
    }
}
