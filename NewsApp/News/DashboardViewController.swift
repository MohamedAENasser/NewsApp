//
//  DashboardViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeItemView: BottomItemView!
    @IBOutlet weak var favoritesItemView: BottomItemView!

    var newsModel: NewsModel?
    var favoritesModel: [ArticleModel] = []
    var mode: DashboardMode = .home {
        didSet {
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        }
    }

    override func viewDidLoad() {
        setupBottomView()
        registerCell()
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        fetchAllData(categories: UserDefaults.favoriteCategories) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func setupBottomView() {
        bottomViewHeightConstraint.constant = 70
        if #available(iOS 11.0, *) {
            bottomViewHeightConstraint.constant += view.safeAreaInsets.bottom
        }
        bottomView.layer.cornerRadius = 10
        homeItemView.setup(titleText: "Home", imageName: "home", isSelected: true) { [weak self] in
            guard let self = self else { return }
            self.favoritesItemView.unSelect()
            self.mode = .home
        }
        favoritesItemView.setup(titleText: "Favorites", imageName: "favorite") { [weak self] in
            guard let self = self else { return }
            self.homeItemView.unSelect()
            self.mode = .favorite
        }
    }

    @IBAction func resetButton(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }

    func registerCell() {
        let articleCell = UINib(nibName: "ArticleCell",
                                bundle: .main)
        tableView.register(articleCell,
                           forCellReuseIdentifier: UIConstants.articleCellID)
    }

    func fetchAllData(categories: [String], completion: @escaping () -> Void) {
        fetchNewsData(category: categories.first ?? "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                if self.newsModel == nil {
                    self.newsModel = model
                } else {
                    self.newsModel?.articles += model.articles
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            if categories.isEmpty {
                completion()
            } else {
                var remainingCategories = categories
                remainingCategories.removeFirst()
                self.fetchAllData(categories: remainingCategories, completion: completion)
            }
        }
    }

    func fetchNewsData(category: String, completion: @escaping (Result<NewsModel, Error>) -> Void) {
        guard let urlComponents = NSURLComponents(string: RequestConstants.baseURL) else {
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: UserDefaults.country),
            URLQueryItem(name: "category", value: category)
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
