//
//  DashboardViewController+TableView.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dashboardMode {
        case .home:
            return newsModel?.articles.count ?? 0
        case .favorite:
            return favoritesModel.count
        case .search:
            return searchModel?.articles.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.articleCellID) as? ArticleCell else {
            return UITableViewCell()
        }
        var article = ArticleModel()
        switch dashboardMode {
        case .home:
            guard let newsModel = newsModel,
                  indexPath.row < newsModel.articles.count else {
                return UITableViewCell()
            }
            article = newsModel.articles[indexPath.row]
        case .favorite:
            article = favoritesModel[indexPath.row]
        case .search:
            guard let searchModel = searchModel,
                  indexPath.row < searchModel.articles.count else {
                return UITableViewCell()
            }
            article = searchModel.articles[indexPath.row]
        }
        let isFavorite = favoritesModel.map { $0.url }.contains(article.url)
        cell.setup(
            with: article,
            cachedImage: imagesCache.object(forKey: NSString(string: article.url ?? "")),
            isFavorite: isFavorite,
            delegate: self) { [weak self] key, image in
            guard let self = self else { return }
            self.imagesCache.setObject(image, forKey: NSString(string: key))
        }
        return cell
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension DashboardViewController: ArticleCellDelegate {
    func favoriteStatusDidChange(_ model: ArticleModel, _ newStatus: Bool) {
        if newStatus {
            favoritesModel.insertWithCondition(model) {
                ($0.publishedAt ?? "") > ($1.publishedAt ?? "")
            }
        } else {
            favoritesModel = favoritesModel.filter { $0 != model }
        }
    }
}
