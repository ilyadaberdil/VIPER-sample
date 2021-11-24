//
//  UIView+Shadow.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor = .csShadowColor,
                    opacity: Float = 1,
                    offSet: CGSize = CGSize(width: -1, height: 1),
                    radius: CGFloat = 3,
                    scale: Bool = true) {
        DispatchQueue.main.async {
            self.layer.masksToBounds = false
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOpacity = opacity
            self.layer.shadowOffset = offSet
            self.layer.shadowRadius = radius
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }
}

