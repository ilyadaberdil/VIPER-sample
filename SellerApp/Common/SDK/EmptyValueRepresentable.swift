//
//  EmptyValueRepresentable.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import UIKit

protocol EmptyValueRepresentable {
    static var emptyValue: Self { get }
}

extension Array: EmptyValueRepresentable {
    static var emptyValue: Array<Element> {
        return []
    }
}

extension Set: EmptyValueRepresentable {
    static var emptyValue: Set<Element> {
        return []
    }
}

extension String: EmptyValueRepresentable {
    static var emptyValue: String {
        ""
    }
}

extension UIEdgeInsets: EmptyValueRepresentable {
    static var emptyValue: UIEdgeInsets {
        return .zero
    }
}

extension Dictionary: EmptyValueRepresentable {
    static var emptyValue: Dictionary {
        return [:]
    }
}
