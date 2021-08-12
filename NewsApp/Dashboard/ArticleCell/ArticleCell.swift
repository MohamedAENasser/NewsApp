//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 09/08/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    var model: ArticleModel?
    weak var delegate: ArticleCellDelegate?
    var url = ""
    var isFavorite = false

    override func prepareForReuse() {
        super.prepareForReuse()
        url = ""
        articleImageView?.image = nil
        isFavorite = false
        favoriteButton.setImage(
            UIImage(named: "favorite_unselected"),
            for: .normal)
    }

    func setup(with model: ArticleModel, isFavorite: Bool, delegate: ArticleCellDelegate?) {
        self.model = model
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        sourceLabel.text = "\("dashboard_source_prefix".localized): \(model.source.name)"
        setupImage(from: model.urlToImage ?? "")
        url = model.url ?? ""
        backgroundColor = .systemGray4
        self.isFavorite = isFavorite
        setupFavoritStatus(isFavorite: isFavorite)
        setupDate()
        self.delegate = delegate
    }

    func setupImage(from imageURL: String) {
        guard let url = URL(string: imageURL) else {
            DispatchQueue.main.async {
                self.articleImageView.image = UIImage(named: "imageNotFound")
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.articleImageView.image = UIImage(named: "imageNotFound")
                }
                return
            }
            DispatchQueue.main.async {
                self.articleImageView.image = UIImage(data: data)
            }
        }.resume()
    }

    func setupDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: model?.publishedAt ?? "")
        guard let date = date else { return }
        dateLabel.text = Date().offset(from: date)
    }

    func setupFavoritStatus(isFavorite: Bool) {
        favoriteButton.setImage(
            UIImage(named: isFavorite ? "favorite_selected" : "favorite_unselected"),
            for: .normal)
    }

    @IBAction func favoriteButtonDidPress(_ sender: UIButton) {
        isFavorite.toggle()
        setupFavoritStatus(isFavorite: isFavorite)
        guard let model = model else { return }
        delegate?.favoriteStatusDidChange(model, isFavorite)
    }

    @IBAction func cellButtonDidPress(_ sender: UIButton) {
        guard let url = URL(string: model?.url ?? "") else {
            return
        }
        UIApplication.shared.open(url)
    }
}
