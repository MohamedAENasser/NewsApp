//
//  String+Localized.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 12/08/2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
}
