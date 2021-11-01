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
    
    func fetchNetwork<T: Codable>(headers: [String:String], request: NSMutableURLRequest, expecting: T.Type, completion: @escaping (T) -> Void) {
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error { print(error); return }
            if let response = response { print(response)}
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let user = try decoder.decode(T.self, from: data)
                completion(user)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
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
