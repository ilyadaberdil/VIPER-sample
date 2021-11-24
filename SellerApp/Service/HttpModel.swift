//
//  HttpModel.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 23.11.2021.
//

import Foundation
import Alamofire

struct HttpModel {
    let method: HTTPMethod
    let path: String
    let headers: HTTPHeaders
    let parameters: Parameters?
    let encoding: ParameterEncoding
    
    init(method: HTTPMethod = .get,
         path: String,
         headers: HTTPHeaders = .default,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = JSONEncoding.default) {
        self.method = method
        self.path = path
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}

extension Alamofire.Session {
    func request(_ url: URL, with model: HttpModel) -> DataRequest {
        return AF.request(url,
                          method: model.method,
                          parameters: model.parameters,
                          encoding: model.encoding,
                          headers: model.headers)
    }
}
