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
    var url: String = ""

    override func prepareForReuse() {
        super.prepareForReuse()
        url = ""
        articleImageView?.image = nil
    }

    func setup(with model: ArticleModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        dateLabel.text = model.publishedAt
        sourceLabel.text = "By: \(model.source.name)"
        setupImage(from: model.urlToImage ?? "")
        url = model.url ?? ""
        backgroundColor = .systemGray4
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
}
