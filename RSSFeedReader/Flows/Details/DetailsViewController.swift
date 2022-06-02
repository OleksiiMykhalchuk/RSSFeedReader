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
            descriptionText.attributedText = NSAttributedString.attributedString(string: htmlString ?? "")
            descriptionText.font = .systemFont(ofSize: 20)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        viewModel.start()
        detailsViewModel = viewModel.details
    }
}
