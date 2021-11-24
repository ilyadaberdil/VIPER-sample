//
//  Service.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import Foundation
import Alamofire


typealias APICompletionHandler<T> = (Result<T, Error>) -> Void

final class Service { }

extension Service: ServiceProtocol {
    func execute<T>(_ type: T.Type,
                    model: HttpModel,
                    completionHandler: @escaping APICompletionHandler<T>) where T: Decodable {
        
        guard let encodePath = model.path.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let url = URL(string: encodePath) else {
            completionHandler(.failure(APIError.generic))
            return
        }
        
        AF.request(url, with: model).responseJSON { dataResponse in
            
            // Sample Check - 401 Unauthorized Error
            if let statusCode = dataResponse.response?.statusCode, statusCode == 401 {
                completionHandler(.failure(APIError.hiddenError))
                return
            }
            
            switch dataResponse.result {
            case .success:
                do {
                    guard let data = dataResponse.data else {
                      completionHandler(.failure(APIError.generic))
                      return
                    }
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch(let error) {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
