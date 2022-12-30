//
//  ServiceLayer.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 29/12/2022.
//

import Foundation

class ServiceLayer {
    
    
    private let allowedDiskSize = 100 * 1024 * 1024
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "gifCache")
    }()

    typealias DownloadCompletionHandler = (Result<Data,Error>) -> ()

    private func createAndRetrieveURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        return URLSession(configuration: sessionConfiguration)
    }

    func downloadContent(fromUrlString: String, completionHandler: @escaping DownloadCompletionHandler) {

        guard let downloadUrl = URL(string: fromUrlString) else { return }
        let urlRequest = URLRequest(url: downloadUrl)
        // First try to fetching cached data if exist
        if let cachedData = self.cache.cachedResponse(for: urlRequest) {
            print("Cached data in bytes:", cachedData.data)
            completionHandler(.success(cachedData.data))

        } else {
            // No cached data, download content than cache the data
            createAndRetrieveURLSession().dataTask(with: urlRequest) { (data, response, error) in

                if let error = error {
                    completionHandler(.failure(error))
                } else {

                    let cachedData = CachedURLResponse(response: response!, data: data!)
                    self.cache.storeCachedResponse(cachedData, for: urlRequest)

                    completionHandler(.success(data!))
                }
            }.resume()
        }
    }
}
