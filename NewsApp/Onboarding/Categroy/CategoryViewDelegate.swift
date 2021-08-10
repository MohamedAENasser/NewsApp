//
//  CategoryViewDelegate.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import Foundation

protocol CategoryViewDelegate: AnyObject {
    func categoryDidPress(name: String, isSelected: Bool)
    func isUpdateAllowed(isSelected: Bool) -> Bool
}
