//
//  InfoBadgeViewModel.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import UIKit

struct InfoBadgeViewModel: Equatable {
    let info: String
    let style: Style
    
    struct Style: Equatable {
        let backgroundColor: UIColor
        let textColor: UIColor
        let font: UIFont
        let cornerRadius: CGFloat
    }
    
    init(info: String, style: Style = .newInfoStyle) {
        self.info = info
        self.style = style
    }
}

extension InfoBadgeViewModel.Style {
    
    static let newInfoStyle: Self = .init(backgroundColor: .csLightGreen,
                                          textColor: .csDarkGreen,
                                          font: UIFont.boldSystemFont(ofSize: 11),
                                          cornerRadius: 5)
    
    static let readInfoStyle: Self = .init(backgroundColor: .csLightGray,
                                           textColor: .csDarkGray,
                                           font: UIFont.boldSystemFont(ofSize: 11),
                                           cornerRadius: 5)
}
