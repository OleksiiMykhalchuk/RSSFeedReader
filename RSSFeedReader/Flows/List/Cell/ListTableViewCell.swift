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
            let data = htmlString?.data(using: .utf8)
            let attributedString = try? NSAttributedString(
                data: data!,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            titleLabel.text = viewModel?.title
            descriptionLabel.attributedText = attributedString
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
