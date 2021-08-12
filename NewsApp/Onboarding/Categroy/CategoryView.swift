//
//  CategoryView.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

class CategoryView: UIView {
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var isSelectedImageView: UIImageView!
    weak var delegate: CategoryViewDelegate?

    func setup(name: String, delegate: CategoryViewDelegate?) {
        categoryNameLabel.text = name.localized
        self.delegate = delegate
        isSelectedImageView.image = isSelectedImageView.image?.withRenderingMode(.alwaysTemplate)
        isSelectedImageView.tintColor = .checkBoxUnSelectedColor
    }

    @IBAction func viewDidPress(_ sender: UIButton) {
        let isSelected =  isSelectedImageView.tintColor == .checkBoxSelectedColor
        if !(delegate?.isUpdateAllowed(isSelected: isSelected) ?? false) { return }
        if isSelected {
            isSelectedImageView.tintColor = .checkBoxUnSelectedColor
        } else {
            isSelectedImageView.tintColor = .checkBoxSelectedColor
        }
        delegate?.categoryDidPress(
            name: categoryNameLabel.text ?? "",
            isSelected: !isSelectedImageView.isHidden)
    }
}
