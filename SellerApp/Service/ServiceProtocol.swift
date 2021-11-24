//
//  ServiceProtocol.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import Foundation

protocol ServiceProtocol {
    func execute<T>(_ type: T.Type,
                    model: HttpModel,
                    completionHandler: @escaping APICompletionHandler<T>) where T: Decodable
}
