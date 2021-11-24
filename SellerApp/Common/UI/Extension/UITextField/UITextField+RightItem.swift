//
//  UITextField+RightItem.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 22.11.2021.
//

import UIKit

extension UITextField {
    
    func appendDownArrowAsRightItem() {
        let rightView = UIView(frame: .init(origin: .zero,
                                            size: .init(width: 32, height: 32)))
        let imageView = UIImageView(image: UIImage(named: "downArrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        rightView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.size.equalTo(12)
        }
        self.rightView = rightView
    }
}
