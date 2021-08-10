//
//  ArticleCellDelegate.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import Foundation

protocol ArticleCellDelegate: AnyObject {
    func favoriteStatusDidChange(_ model: ArticleModel, _ newStatus: Bool)
}
