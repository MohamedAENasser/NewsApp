//
//  UserDefaults+Preferences.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

extension UserDefaults {
    var shouldSkipOnboarding: Bool {
        get {
            bool(forKey: "ShouldSkipOnboardingKey")
        }
        set {
            setValue(newValue, forKey: "ShouldSkipOnboardingKey")
        }
    }

    var favoriteCategories: [String] {
        get {
            object(forKey: "FavoriteCategoriesKey") as? [String] ?? []
        }
        set {
            setValue(newValue, forKey: "FavoriteCategoriesKey")
        }
    }

    var country: String {
        get {
            string(forKey: "CountryKey") ?? ""
        }
        set {
            setValue(newValue, forKey: "CountryKey")
        }
    }
}
