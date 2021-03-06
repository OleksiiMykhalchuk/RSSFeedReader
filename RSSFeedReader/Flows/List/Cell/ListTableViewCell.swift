//
//  ListTableViewCell.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/26/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    var viewModel: RSSItem? {
        didSet {
            let htmlString = viewModel?.description
            titleLabel.text = viewModel?.title
            descriptionLabel.attributedText = NSAttributedString.attributedString(string: htmlString ?? "")
            descriptionLabel.sizeToFit()
            descriptionLabel.font = UIFont(name: "system", size: 14)
            descriptionLabel.layoutIfNeeded()
            pubDateLabel.text = viewModel?.pubDate
            source.text = viewModel?.source
        }
    }
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
