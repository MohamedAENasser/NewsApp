//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var newsModel: NewsModel?
    var countryCode = ""
    var favoriteCategories: [String] = []

    override func viewDidLoad() {
        registerCell()
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        fetchNewsData { [weak self] result in
            switch result {
            case .success(let model):
                guard let self = self else { return }
                self.newsModel = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func registerCell() {
        let articleCell = UINib(nibName: "ArticleCell",
                                bundle: .main)
        tableView.register(articleCell,
                           forCellReuseIdentifier: UIConstants.articleCellID)
    }

    func initializeUserPreferences(
        countryCode: String,
        favoriteCategories: [String]) {
        self.countryCode = countryCode
        self.favoriteCategories = favoriteCategories
    }

    func fetchNewsData(completion: @escaping (Result<NewsModel, Error>) -> Void) {
        guard let urlComponents = NSURLComponents(string: RequestConstants.baseURL) else {
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: countryCode)
        ]
        guard let url = urlComponents.url else { return }
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
