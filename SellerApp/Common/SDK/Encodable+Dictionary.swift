//
//  Encodable+Dictionary.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 23.11.2021.
//

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
