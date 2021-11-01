//
//  NetworkManager.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(headers: [String:String], request: NSMutableURLRequest,complition: @escaping(Result<Data, Error>) -> Void) {
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            complition(.success(data))
        }.resume()
    }
    
}
