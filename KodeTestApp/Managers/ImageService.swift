//
//  ImageService.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

class ImageService {
    static let shared = ImageService()
    
    private init() {}
    
    func getImage(from url: URL, complition: @escaping (Data, URLResponse) -> Void ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            guard  url == responseURL else { return }
            complition(data, response)
        }.resume()
    }
}
