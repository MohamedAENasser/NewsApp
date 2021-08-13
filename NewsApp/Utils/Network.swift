//
//  Network.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

struct Network {
    func fetchNews(
        endPoint: EndPoint = .topHeading,
        headers: [String: String] = [:],
        parameters: [String: String] = [:],
        completion: @escaping (Result<NewsModel, Error>) -> Void) {
        guard let urlComponents = NSURLComponents(string: RequestConstants.baseURL + endPoint.rawValue) else {
            return
        }

        urlComponents.queryItems = []
        parameters.forEach { key, value in
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)

        var finalHeader = headers
        finalHeader["X-Api-Key"] = RequestConstants.apiKey
        finalHeader["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = finalHeader

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 3.0
        sessionConfig.timeoutIntervalForResource = 6.0
        let session = URLSession(configuration: sessionConfig)

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let model = try? JSONDecoder().decode(NewsModel.self, from: data) else {
                completion(.failure(error ?? NetworkError.defaultError))
                return
            }
            completion(.success(model))
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case defaultError
}

enum EndPoint: String {
    case topHeading = "top-headlines"
    case everything
}
