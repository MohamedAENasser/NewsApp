//
//  Constants.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import Foundation

enum Constants {
    enum Request {
        static let baseURL = "https://newsapi.org/v2/"
        static let apiKey = ""
    }

    enum UI {
        static let articleCellID = "ArticleCellID"
    }

    enum FilesNames {
        static let latestResponse = "DashboardLatestResponseCache"
        static let latestFavoritesResponse = "latestFavoritesResponseCache"
    }

}
