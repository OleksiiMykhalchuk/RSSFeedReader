//
//  DetailsViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class DetailsViewController: UIViewController, ViewModelApplyied, ViewControllerMakeable {
    var viewModel: ViewModel!
    var detailsViewModel: DetailsViewModel? {
        didSet {
            let htmlString = detailsViewModel?.description
            titleLabel.text = detailsViewModel?.title
            descriptionLabel.attributedText = NSAttributedString.attributedString(string: htmlString ?? "")
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        viewModel.start()
        detailsViewModel = viewModel.details
    }
}
