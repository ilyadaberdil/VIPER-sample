//
//  UIView+Toolbar.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 22.11.2021.
//

import UIKit

extension UIView {
    
    func getPickerToolbar(applyAction: Selector?, closeAction: Selector? = nil) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let applyButton = UIBarButtonItem(title: "Uygula",
                                          style: .plain,
                                          target: self,
                                          action: applyAction)
        
        let closeButton = UIBarButtonItem(title: "Kapat",
                                          style: .plain,
                                          target: self,
                                          action: closeAction ?? #selector(toolbarDefaultCloseAction(_:)))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([closeButton, spacer, applyButton], animated: true)
        
        return toolbar
    }
    
    @objc private func toolbarDefaultCloseAction(_ toolbar: UIToolbar) {
        resignFirstResponder()
    }
}
