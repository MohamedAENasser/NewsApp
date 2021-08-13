//
//  DashboardViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeItemView: BottomItemView!
    @IBOutlet weak var favoritesItemView: BottomItemView!

    var newsModel: NewsModel?
    var favoritesModel: [ArticleModel] = [] {
        didSet {
            // Saving the whole object not only URLs as it's not guaranteed that same article will be fetched in the future
            saveResponse(model: favoritesModel, to: Constants.FilesNames.latestFavoritesResponse)
            if dashboardMode == .favorite {
                reloadTableView()
            }
        }
    }
    var searchModel: NewsModel?
    var dashboardMode: DashboardMode = .home {
        didSet {
            if oldValue == dashboardMode { return }
            reloadTableView()
        }
    }
    var latestMode: DashboardMode = .home
    var searchText = "" {
        didSet {
            if searchText.isEmpty {
                dashboardMode = latestMode
            }
        }
    }
    var network: Network?
    let imagesCache = NSCache<NSString, UIImage>()

    override func viewDidLoad() {
        network = Network()
        hideKeyboardWhenTappedAround()
        setupBottomView()
        registerCell()
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        retrieveResponse(
            from: Constants.FilesNames.latestFavoritesResponse, type: [ArticleModel].self) { model in
            favoritesModel = model ?? []
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fetchAllData(categories: UserDefaults.standard.favoriteCategories) {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }

    func setupBottomView() {
        bottomViewHeightConstraint.constant = 70
        if #available(iOS 11.0, *) {
            bottomViewHeightConstraint.constant += view.safeAreaInsets.bottom
        }
        bottomView.layer.cornerRadius = 10
        homeItemView.setup(titleText: "dashboard_home".localized, imageName: "home", isSelected: true) { [weak self] in
            guard let self = self else { return }
            self.favoritesItemView.unSelect()
            self.dashboardMode = .home
        }
        favoritesItemView.setup(titleText: "dashboard_favorites".localized, imageName: "favorite") { [weak self] in
            guard let self = self else { return }
            self.homeItemView.unSelect()
            self.dashboardMode = .favorite
        }
    }

    func registerCell() {
        let articleCell = UINib(nibName: "ArticleCell",
                                bundle: .main)
        tableView.register(articleCell,
                           forCellReuseIdentifier: Constants.UI.articleCellID)
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        }
    }

    func fetchAllData(categories: [String], completion: @escaping () -> Void) {
        network?.fetchNews(
            headers:["category": categories.first ?? ""],
            parameters: ["country": UserDefaults.standard.country]
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                if self.newsModel == nil {
                    self.newsModel = model
                } else {
                    let sortedUniqueArray = Array(Set(self.newsModel?.articles ?? [] + model.articles)).sorted(by: { ($0.publishedAt ?? "") > ($1.publishedAt ?? "") })

                    self.newsModel?.articles = sortedUniqueArray
                }
            case .failure(_):
                self.retrieveResponse(from: Constants.FilesNames.latestResponse, type: NewsModel.self) { [weak self] model in
                    guard let self = self,
                          let model = model else {
                        return
                    }
                    self.newsModel = model
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                return
            }
            if categories.isEmpty {
                if let newsModel = self.newsModel {
                    DispatchQueue.global(qos: .background).async {
                        self.saveResponse(model: newsModel, to: Constants.FilesNames.latestResponse)
                    }
                }
                completion()
            } else {
                var remainingCategories = categories
                remainingCategories.removeFirst()
                self.fetchAllData(categories: remainingCategories, completion: completion)
            }
        }
    }
}
