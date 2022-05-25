//
//  LoginViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class LoginViewController: UIViewController {
  var viewModel: LoginViewModel?
  @IBOutlet weak var registerButton: UIButton!
  @IBAction func registerButtonTapped(_ sender: Any) {
    viewModel?.goToRegister()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
