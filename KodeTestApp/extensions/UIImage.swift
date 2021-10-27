//
//  UIImage.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { return }
        if let cachedImage = getCacheImage(url: url) {
            image = cachedImage
            return
        }
        
        ImageService.shared.getImage(from: url) {[weak self] (data, response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            self.saveDataToCach(with: data, response: response)
        }
    }
    
    private func getCacheImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let chacheedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: chacheedResponse.data)
        }
       return nil
    }
    
    private func saveDataToCach(with data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let chacheedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(chacheedResponse, for: urlRequest)
         
    }
}
