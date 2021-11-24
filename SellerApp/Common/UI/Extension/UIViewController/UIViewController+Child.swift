//
//  UIViewController+Child.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 24.11.2021.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ viewController: UIViewController, in subView: UIView? = nil) {
        
        if let subView = subView {
            subView.addSubview(viewController.view)
        } else {
            view.addSubview(viewController.view)
        }
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func removeViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
