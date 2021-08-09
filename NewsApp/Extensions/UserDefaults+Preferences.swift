//
//  UserDefaults+Preferences.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

extension UserDefaults {
    static var shouldSkipOnboarding: Bool {
        get {
            standard.bool(forKey: "ShouldSkipOnboardingKey")
        }
        set {
            standard.setValue(newValue, forKey: "ShouldSkipOnboardingKey")
        }
    }

    static var favoriteCategories: [String] {
        get {
            standard.object(forKey: "FavoriteCategoriesKey") as? [String] ?? []
        }
        set {
            standard.setValue(newValue, forKey: "FavoriteCategoriesKey")
        }
    }

    static var country: String {
        get {
            standard.string(forKey: "CountryKey") ?? ""
        }
        set {
            standard.setValue(newValue, forKey: "CountryKey")
        }
    }
}
