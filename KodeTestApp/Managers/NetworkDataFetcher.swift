//
//  NetworkDataFetcher.swift
//  KodeTestApp
//
//  Created by Клим on 01.11.2021.
//

import Foundation

class NetworkDataFetcher {
    
    static let shared = NetworkDataFetcher()
    
    private init() {}
    
    func getData<T: Decodable>(headers: [String:String], request: NSMutableURLRequest, decodeType: T.Type, response: @escaping (T?) -> Void) {
        NetworkManager.shared.fetchData(headers: headers, request: request){ (result) in
            switch result {
            case .success(let data):
                do {
                    let cities = try JSONDecoder().decode(T.self, from: data)
                    response(cities)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                    response(nil)
                }
            case .failure(_ :):
                response(nil)
            }
        }
    }
}
