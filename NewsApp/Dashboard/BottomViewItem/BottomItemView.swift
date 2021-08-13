//
//  BottomItemView.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

class BottomItemView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var action: () -> Void = {}

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonSetup()
    }

    private func loadViewFromNib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("BottomItemView", owner: self, options: nil)?.first as? UIView else {
            return UIView()
        }
        return view
    }

    private func commonSetup() {
        let nibView = loadViewFromNib()
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
    }

    func setup(
        titleText: String,
        imageName: String,
        isSelected: Bool = false,
        buttonAction: @escaping () -> Void) {
        titleLabel.text = titleText
        imageView.image = UIImage(named: imageName)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        if isSelected {
            select()
        } else {
            unSelect()
        }
        action = buttonAction
    }

    func select() {
        imageView.tintColor = .tabSelectedColor
        titleLabel.textColor = .tabSelectedColor
    }

    func unSelect() {
        imageView.tintColor = .tabUnSelectedColor
        titleLabel.textColor = .tabUnSelectedColor
    }

    @IBAction func buttonDidPress(_ sender: UIButton) {
        select()
        action()
    }
}
