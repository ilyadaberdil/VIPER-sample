//
//  NotificationResponse.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

struct NotificationResponse: Decodable {
    var sellerList: [Notification]
}

struct Notification: Decodable {
    let title: String
    let preDescription: String
    let date: String
    let isRead: Bool
}
