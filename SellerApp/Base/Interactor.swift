//
//  Interactor.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import Foundation

class Interactor {
    var service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
}
