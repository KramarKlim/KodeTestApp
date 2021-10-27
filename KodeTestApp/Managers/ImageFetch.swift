//
//  ImageFetch.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

class ImageFetch {
    
    static let shared = ImageFetch()
    
    private init() {}
    
    func fetchImageData(from url: String) -> Data? {
        guard let imageURL = URL(string: url) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return imageData
    }
}
