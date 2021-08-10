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
        categoryNameLabel.text = name
        self.delegate = delegate
        isSelectedImageView.image = isSelectedImageView.image?.withRenderingMode(.alwaysTemplate)
        isSelectedImageView.tintColor = .systemGray3
    }

    @IBAction func viewDidPress(_ sender: UIButton) {
        let isSelected =  isSelectedImageView.tintColor == .green
        if !(delegate?.isUpdateAllowed(isSelected: isSelected) ?? false) { return }
        if isSelected {
            isSelectedImageView.tintColor = .systemGray3
        } else {
            isSelectedImageView.tintColor = .green
        }
        delegate?.categoryDidPress(
            name: categoryNameLabel.text ?? "",
            isSelected: !isSelectedImageView.isHidden)
    }
}
