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
        // the autoresizingMask will be converted to constraints, the frame will match the parent view frame
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Adding nibView on the top of our view
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
        imageView.tintColor = UIColor.systemBlue
        titleLabel.textColor = UIColor.systemBlue
    }

    func unSelect() {
        imageView.tintColor = UIColor.systemGray3
        titleLabel.textColor = UIColor.black
    }

    @IBAction func buttonDidPress(_ sender: UIButton) {
        select()
        action()
    }
}
