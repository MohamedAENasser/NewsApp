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

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchText = ""
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        network?.fetchNews(
            endPoint: .everything,
            parameters: ["q": searchText]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.searchModel = model
                self.latestMode = self.dashboardMode
                self.dashboardMode = .search
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
