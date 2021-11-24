//
//  UIViewController+Loading.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import UIKit

extension UIViewController {
    
    private enum Const {
        static let loadingViewTag = 901995
        static let loadingCornerRadius: CGFloat = 16.0
        static let loadingViewSize = CGSize(width: 80.0, height: 80.0)
    }

    private var loadingView: UIView {
        let loadingView = UIView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.tag = Const.loadingViewTag
        loadingView.layer.cornerRadius = Const.loadingCornerRadius
        loadingView.backgroundColor = .gray
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        loadingView.addSubview(indicator)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return loadingView
    }
    
    func showLoading(isUserInteractionEnabled: Bool = false) {
        guard view.viewWithTag(Const.loadingViewTag) == nil else {
            return
        }
        let loadingView = loadingView
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Const.loadingViewSize)
        }
        setUserInteraction(isUserInteractionEnabled)
    }
    
    func hideLoading() {
        let loadingView = view.viewWithTag(Const.loadingViewTag)
        loadingView?.removeFromSuperview()
        setUserInteraction(true)
    }
    
    private func setUserInteraction(_ enabled: Bool) {
        navigationController?.navigationBar.isUserInteractionEnabled = enabled
        view.isUserInteractionEnabled = enabled
    }
}
