//
//  UITableView+Register.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type))
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell!")
        }
        return cell
    }
}
