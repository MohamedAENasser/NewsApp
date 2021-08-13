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
    var isSelected: Bool = false {
        didSet {
            isSelectedImageView.tintColor = isSelected ? .checkBoxSelectedColor : .checkBoxUnSelectedColor
        }
    }

    func setup(name: String, delegate: CategoryViewDelegate?) {
        categoryNameLabel.text = name.localized
        self.delegate = delegate
        isSelectedImageView.image = isSelectedImageView.image?.withRenderingMode(.alwaysTemplate)
        isSelected = false
    }

    @IBAction func viewDidPress(_ sender: UIButton) {
        if !(delegate?.isUpdateAllowed(isSelected: isSelected) ?? false) { return }
        isSelected.toggle()
        delegate?.categoryDidPress(
            name: categoryNameLabel.text ?? "",
            isSelected: !isSelectedImageView.isHidden)
    }
}
