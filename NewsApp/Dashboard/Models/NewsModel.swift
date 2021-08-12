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

struct ArticleModel: Codable, Equatable {
    var source: SourceModel
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    init() {
        source = SourceModel(id: nil, name: "")
        author = nil
        title = nil
        description = nil
        url = nil
        urlToImage = nil
        publishedAt = nil
        content = nil
    }

    enum CodingKeys: CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }

    static func ==(lhs: ArticleModel, rhs: ArticleModel) -> Bool {
        return lhs.source == rhs.source &&
        lhs.author == rhs.author &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.url == rhs.url &&
        lhs.urlToImage == rhs.urlToImage &&
        lhs.publishedAt == rhs.publishedAt &&
        lhs.content == rhs.content
    }
}

struct SourceModel: Codable, Equatable {
    var id: String?
    var name: String

    enum CodingKeys: CodingKey {
        case id
        case name
    }

    static func ==(lhs: SourceModel, rhs: SourceModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}
