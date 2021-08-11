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
    @IBOutlet weak var countryWarningLabel: UILabel!
    @IBOutlet weak var categoriesWarningLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    var pickerView: UIPickerView?
    var toolBar: UIToolbar?
    var countries: [String: String] = [:]

    var selectedCategories: [String] = [] {
        didSet {
            UserDefaults.favoriteCategories = selectedCategories
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        startButton.layer.cornerRadius = startButton.frame.height / 2
        setupCountryTextField()
        setupCategories()
    }

    func setupCategories() {
        Configuration.availableCategories.forEach { category in
            guard let categoryView = Bundle.main.loadNibNamed("CategoryView", owner: nil, options: nil)?.first as? CategoryView else {
                return
            }
            categoryView.setup(name: category, delegate: self)
            categoriesStackView.addArrangedSubview(categoryView)
        }
    }

    @IBAction func startButtonDidPress(_ sender: UIButton) {
        countryWarningLabel.isHidden =
            !(countriesTextField.text?.isEmpty ?? true)
        categoriesWarningLabel.isHidden =
            selectedCategories.count == 3
        if !countryWarningLabel.isHidden || !categoriesWarningLabel.isHidden {
            return
        }
        presentDashboardViewController()
        UserDefaults.shouldSkipOnboarding = true
    }
}

extension OnboardingViewController: CategoryViewDelegate {
    func categoryDidPress(name: String, isSelected: Bool) {
        categoriesWarningLabel.isHidden = true
        if isSelected, !selectedCategories.contains(name) {
            selectedCategories.append(name)
        } else {
            selectedCategories = selectedCategories.filter { $0 != name }
        }
    }

    func isUpdateAllowed(isSelected: Bool) -> Bool {
        selectedCategories.count < 3 || isSelected
    }
}
