//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var countriesTextField: UITextField!

    var pickerView: UIPickerView?
    var toolBar: UIToolbar?
    var countries: [String: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCountryTextField()
    }

    @IBAction func startButtonDidPress(_ sender: UIButton) {
        presentNewsViewController()
        UserDefaults.shouldSkipOnboarding = true
    }
}

extension OnboardingViewController {
    func setupCountryTextField() {
         Locale.isoRegionCodes.forEach { code in
            countries[Locale.current.localizedString(forRegionCode: code) ?? ""] =
            code
        }

        pickerView = UIPickerView()
        toolBar = UIToolbar()
        guard let pickerView = pickerView,
              let toolBar = toolBar else { return }

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white

        // ToolBar initialization
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .gray
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        countriesTextField.inputView = pickerView
        countriesTextField.inputAccessoryView = toolBar
    }

    @objc func doneButtonTapped() {
        guard let selectedRow = pickerView?.selectedRow(inComponent: 0) else {
            cancelButtonTapped()
            return
        }
        countriesTextField.resignFirstResponder()
        if !countries.isEmpty,
           0..<countries.count ~= selectedRow {
            let index = countries.index(countries.startIndex, offsetBy: selectedRow)
            countriesTextField.text = countries.keys[index]
            UserDefaults.country = countries.values[index]
        }
    }

    @objc func cancelButtonTapped() {
        countriesTextField.resignFirstResponder()
    }
}

// MARK: - UIPickerViewDataSource
extension OnboardingViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
}

// MARK: - UIPickerViewDelegate
extension OnboardingViewController: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let index = countries.index(countries.startIndex, offsetBy: row)
        return countries.keys[index]
    }
}
