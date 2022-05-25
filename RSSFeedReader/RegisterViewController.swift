//
//  RegisterViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class RegisterViewController: UIViewController {
  var viewModel: RegisterViewModel?
  @IBOutlet weak var backToLoginButton: UIButton!
  @IBAction func backToLoginTapped(_ sender: Any) {
    viewModel?.goToLogin()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
