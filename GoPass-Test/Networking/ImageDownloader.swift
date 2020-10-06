//
//  ImageDownloader.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private let cache = URLCache.shared

    func getImage(url: URL, completion: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: url)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = self.cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, _) in
                    if let data = data, let response = response as? HTTPURLResponse, response.statusCode < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        self.cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                }).resume()
            }
        }
    }
}
