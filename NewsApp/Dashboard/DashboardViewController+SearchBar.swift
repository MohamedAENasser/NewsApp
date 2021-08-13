//
//  DashboardViewController+SearchBar.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

extension DashboardViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchText.isEmpty {
            self.dashboardMode = latestMode
        }
        network?.fetchNews(
            endPoint: .everything,
            parameters: ["q": searchText]) { [weak self] result in
            guard let self = self else { return }
            if case .success(let model) = result {
                self.searchModel = model
                self.latestMode = self.dashboardMode
                self.dashboardMode = .search
            }
        }
    }
}
