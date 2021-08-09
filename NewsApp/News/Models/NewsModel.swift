//
//  NewsModel.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import Foundation

struct NewsModel: Codable {
    var status: String
    var totalResults: Int
    var articles: [ArticleModel]

    enum CodingKeys: CodingKey {
        case status
        case totalResults
        case articles
    }
}

struct ArticleModel: Codable {
    var source: SourceModel
    var author: String?
    var title: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: CodingKey {
        case source
        case author
        case title
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

struct SourceModel: Codable {
    var id: String?
    var name: String

    enum CodingKeys: CodingKey {
        case id
        case name
    }
}
