//
//  DashboardViewController+TableView.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mode {
        case .home:
            return newsModel?.articles.count ?? 0
        case .favorite:
            return favoritesModel.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.articleCellID) as? ArticleCell,
              let newsModel = newsModel,
              indexPath.row < newsModel.articles.count else {
            return UITableViewCell()
        }
        var article = ArticleModel()
        switch mode {
        case .home:
            article = newsModel.articles[indexPath.row]
        case .favorite:
            article = favoritesModel[indexPath.row]
        }
        cell.setup(
            with: article,
            isFavorite: favoritesModel.contains(article),
            delegate: self)
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
            favoritesModel.append(model)
        } else {
            favoritesModel = favoritesModel.filter { $0 != model }
        }
    }
}
