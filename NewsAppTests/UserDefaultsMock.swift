//
//  UserDefaultsMock.swift
//  NewsAppTests
//
//  Created by Mohamed Abd ElNasser on 13/08/2021.
//

import Foundation

class UserDefaultsMock {
    var standard: UserDefaults
    private let suiteName = "UserDefaultsMockSuite"

    init() {
        standard = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
    }

    func clear() {
        standard.removePersistentDomain(forName: suiteName)
    }
}
