//
//  NewsModel.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import Foundation

enum NewsModelKeys {
    static let status = "statusKey"
    static let totalResults = "totalResultsKey"
    static let articles = "articlesKey"
}

class NewsModel: NSObject, Codable, NSCoding {
    var status: String
    var totalResults: Int
    var articles: [ArticleModel]

    enum CodingKeys: CodingKey {
        case status
        case totalResults
        case articles
    }

    func encode(with coder: NSCoder) {
        coder.encode(status, forKey: NewsModelKeys.status)
        coder.encode(totalResults, forKey: NewsModelKeys.totalResults)
        coder.encode(articles, forKey: NewsModelKeys.articles)
    }

    required init?(coder: NSCoder) {
        status = coder.decodeObject(forKey: NewsModelKeys.status) as? String ?? ""
        totalResults = coder.decodeInteger(forKey: NewsModelKeys.totalResults)
        articles = coder.decodeObject(forKey: NewsModelKeys.articles) as? [ArticleModel] ?? []
    }
}
