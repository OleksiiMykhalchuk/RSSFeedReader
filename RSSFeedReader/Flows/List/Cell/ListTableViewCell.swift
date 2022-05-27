//
//  ListTableViewCell.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/26/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    var viewModel: ListCellViewModel? {
        didSet {
            let htmlString = viewModel?.description
            titleLabel.text = viewModel?.title
            descriptionLabel.attributedText = NSAttributedString.attributedString(string: htmlString ?? "")
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
