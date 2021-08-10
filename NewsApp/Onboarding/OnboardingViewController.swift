//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var countriesTextField: UITextField!
    @IBOutlet weak var categoriesStackView: UIStackView!

    var pickerView: UIPickerView?
    var toolBar: UIToolbar?
    var countries: [String: String] = [:]
    let availableCategories: [String] = [
        "business",
        "entertainment",
        "general",
        "health",
        "science",
        "sports",
        "technology"
    ]
    // Didn't use Locale.isoRegionCodes as the API specified these codes only
    let availableCountriesCodes: [String] = [
        "ae",
        "ar",
        "at",
        "au",
        "be",
        "bg",
        "br",
        "ca",
        "ch",
        "cn",
        "co",
        "cu",
        "cz",
        "de",
        "eg",
        "fr",
        "gb",
        "gr",
        "hk",
        "hu",
        "id",
        "ie",
        "il",
        "in",
        "it",
        "jp",
        "kr",
        "lt",
        "lv",
        "ma",
        "mx",
        "my",
        "ng",
        "nl",
        "no",
        "nz",
        "ph",
        "pl",
        "pt",
        "ro",
        "rs",
        "ru",
        "sa",
        "se",
        "sg",
        "si",
        "sk",
        "th",
        "tr",
        "tw",
        "ua",
        "us",
        "ve",
        "za"
    ]
    var selectedCategories: [String] = [] {
        didSet {
            UserDefaults.favoriteCategories = selectedCategories
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCountryTextField()
        setupCategories()
    }

    func setupCategories() {
        availableCategories.forEach { category in
            guard let categoryView = Bundle.main.loadNibNamed("CategoryView", owner: nil, options: nil)?.first as? CategoryView else {
                return
            }
            categoryView.setup(name: category, delegate: self)
            categoriesStackView.addArrangedSubview(categoryView)
        }
    }

    @IBAction func startButtonDidPress(_ sender: UIButton) {
        presentNewsViewController()
        UserDefaults.shouldSkipOnboarding = true
    }
}

extension OnboardingViewController: CategoryViewDelegate {
    func categoryDidPress(name: String, isSelected: Bool) {
        if isSelected {
            selectedCategories.append(name)
        } else {
            selectedCategories = selectedCategories.filter { $0 != name }
        }
    }

    func isUpdateAllowed(isSelected: Bool) -> Bool {
        selectedCategories.count < 3 || isSelected
    }
}
