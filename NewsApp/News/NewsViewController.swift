//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class NewsViewController: UIViewController {
    override func viewDidLoad() {
        fetchNewsData { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchNewsData(completion: @escaping (Result<NewsModel, Error>) -> Void) {
        guard let url = URL(string: RequestConstants.baseURL) else {
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-Api-Key": RequestConstants.apiKey,
            "Content-Type": "application/json"
        ]

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
