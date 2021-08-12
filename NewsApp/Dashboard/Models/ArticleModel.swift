//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 12/08/2021.
//

import Foundation

enum ArticleModelKeys {
    static let source = "sourceKey"
    static let author = "authorKey"
    static let title = "titleKey"
    static let description = "descriptionKey"
    static let url = "urlKey"
    static let urlToImage = "urlToImageKey"
    static let publishedAt = "publishedAtKey"
    static let content = "contentKey"
}

class ArticleModel: NSObject, Codable, NSCoding {
    var source: SourceModel
    var author: String?
    var title: String?
    var articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    override init() {
        source = SourceModel()
        author = nil
        title = nil
        articleDescription = nil
        url = nil
        urlToImage = nil
        publishedAt = nil
        content = nil
    }

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }

    func encode(with coder: NSCoder) {
        coder.encode(source, forKey: ArticleModelKeys.source)
        coder.encode(author, forKey: ArticleModelKeys.author)
        coder.encode(title, forKey: ArticleModelKeys.title)
        coder.encode(description, forKey: ArticleModelKeys.description)
        coder.encode(url, forKey: ArticleModelKeys.url)
        coder.encode(urlToImage, forKey: ArticleModelKeys.urlToImage)
        coder.encode(publishedAt, forKey: ArticleModelKeys.publishedAt)
        coder.encode(content, forKey: ArticleModelKeys.content)
    }

    required init?(coder: NSCoder) {
        source = coder.decodeObject(forKey: ArticleModelKeys.source) as? SourceModel ?? SourceModel()
        author = coder.decodeObject(forKey: ArticleModelKeys.author) as? String
        title = coder.decodeObject(forKey: ArticleModelKeys.title) as? String
        articleDescription = coder.decodeObject(forKey: ArticleModelKeys.description) as? String
        url = coder.decodeObject(forKey: ArticleModelKeys.url) as? String
        urlToImage = coder.decodeObject(forKey: ArticleModelKeys.urlToImage) as? String
        publishedAt = coder.decodeObject(forKey: ArticleModelKeys.publishedAt) as? String
        content = coder.decodeObject(forKey: ArticleModelKeys.content) as? String
    }
}
