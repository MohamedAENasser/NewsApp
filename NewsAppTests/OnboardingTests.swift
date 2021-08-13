//
//  OnboardingTests.swift
//  NewsAppTests
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import XCTest
@testable import NewsApp

class OnboardingTests: XCTestCase {
    var onboardingVC: OnboardingViewController!
    var userDefaultsMock: UserDefaultsMock!
    let categories = Configuration.availableCategories

    override func setUp() {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: .main)

        guard let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController else {
            XCTFail("Can't instantiate Onboarding View Controller")
            return
        }
        onboardingVC = onboardingViewController
        userDefaultsMock = UserDefaultsMock()
        onboardingVC.userDefaults = userDefaultsMock.standard
        _ = onboardingVC.view
    }

    override func tearDown() {
        userDefaultsMock.clear()
        onboardingVC = nil
    }

    func testViewControllerInitialization() {
        XCTAssertEqual(categories.count, 7)
    }

    func testCountryTextFieldConfiguration() {
        let countriesCount = 54
        onboardingVC.setupCountryTextField()
        XCTAssertNotNil(onboardingVC.countriesTextField.delegate)
        XCTAssertNotNil(onboardingVC.pickerView)
        XCTAssertNotNil(onboardingVC.toolBar)
        XCTAssertNotNil(onboardingVC.pickerView)
        XCTAssertNotNil(onboardingVC.pickerView)
        XCTAssertEqual(onboardingVC.countries.keys.count, countriesCount)
        XCTAssertEqual(
            onboardingVC.countriesTextField.inputView,
            onboardingVC.pickerView)
        XCTAssertEqual(
            onboardingVC.countriesTextField.inputAccessoryView,
            onboardingVC.toolBar)
        XCTAssertEqual(onboardingVC.pickerView?.numberOfComponents, 1)
        XCTAssertEqual(onboardingVC.pickerView?.numberOfRows(inComponent: 0), countriesCount)
    }

    func testCategorySelection() {
        XCTAssertEqual(onboardingVC.selectedCategories.count, 0)
        tapOnCategories(with: [categories[0]])
        XCTAssertEqual(onboardingVC.selectedCategories.count, 1)
    }

    func testCategoryUnSelection() {
        XCTAssertEqual(onboardingVC.selectedCategories.count, 0)
        tapOnCategories(with: [categories[0]])
        XCTAssertEqual(onboardingVC.selectedCategories.count, 1)
        tapOnCategories(with: [categories[0]])
        XCTAssertEqual(onboardingVC.selectedCategories.count, 0)
    }

    func testMaxNumberOfCategoriesSelection() {
        XCTAssertEqual(onboardingVC.selectedCategories.count, 0)
        tapOnCategories(with: [categories[0], categories[1], categories[2]])
        XCTAssertEqual(onboardingVC.selectedCategories.count, 3)
        tapOnCategories(with: [categories[3]])
        XCTAssertEqual(onboardingVC.selectedCategories.count, 3)
    }

    func testWarningLabels() {
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertFalse(onboardingVC.countryWarningLabel.isHidden)
        XCTAssertFalse(onboardingVC.categoriesWarningLabel.isHidden)
    }

    // Test Country must be selected
    func testCountryWarning() {
        tapOnCategories(with: [categories[0], categories[1], categories[2]])
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertFalse(onboardingVC.countryWarningLabel.isHidden)
        XCTAssertTrue(onboardingVC.categoriesWarningLabel.isHidden)
    }

    // Test categories must be 3 selected
    func testCategoriesWarningWithNoSelection() {
        onboardingVC.countriesTextField.text = "Egypt"
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertTrue(onboardingVC.countryWarningLabel.isHidden)
        XCTAssertFalse(onboardingVC.categoriesWarningLabel.isHidden)
    }

    // Test categories must be 3 selected
    func testCategoriesWarningWithOnceSelection() {
        onboardingVC.countriesTextField.text = "Egypt"
        tapOnCategories(with: [categories[0]])
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertTrue(onboardingVC.countryWarningLabel.isHidden)
        XCTAssertFalse(onboardingVC.categoriesWarningLabel.isHidden)
    }

    // Test categories must be 3 selected
    func testCategoriesWarningWithTwoSelections() {
        onboardingVC.countriesTextField.text = "Egypt"
        tapOnCategories(with: [categories[0], categories[1]])
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertTrue(onboardingVC.countryWarningLabel.isHidden)
        XCTAssertFalse(onboardingVC.categoriesWarningLabel.isHidden)
    }

    // Test categories must be 3 selected
    func testCategoriesWarningWithThreeSelections() {
        onboardingVC.countriesTextField.text = "Egypt"
        tapOnCategories(with: [categories[0], categories[1], categories[2]])
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertTrue(onboardingVC.countryWarningLabel.isHidden)
        XCTAssertTrue(onboardingVC.categoriesWarningLabel.isHidden)
    }

    func testAppearingOnce() {
        XCTAssertFalse(onboardingVC.userDefaults.shouldSkipOnboarding)
        onboardingVC.countriesTextField.text = "Egypt"
        tapOnCategories(with: [categories[0], categories[1], categories[2]])
        onboardingVC.startButtonDidPress(UIButton())
        XCTAssertTrue(onboardingVC.userDefaults.shouldSkipOnboarding)
    }

    // Helper Methods
    func tapOnCategories(with names: [String]) {
        onboardingVC.categoriesStackView.arrangedSubviews.forEach { subView in
            guard let categoryView = subView as? CategoryView,
                  names.contains(categoryView.categoryNameLabel.text ?? "") else {
                return
            }

            categoryView.viewDidPress(UIButton())
            return
        }
    }
}
