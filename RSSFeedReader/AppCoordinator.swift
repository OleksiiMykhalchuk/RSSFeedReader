//
//  AppCoordinator.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
  var parentCoordinator: Coordinator?
  var children: [Coordinator] = []
  var navigationController: UINavigationController

  init(navCon: UINavigationController) {
    self.navigationController = navCon
  }
  func start() {
    print("App Coordinator start")
    goToLoginPage()
  }
  let storyboard = UIStoryboard(name: "Main", bundle: .main)
  func goToLoginPage() {
    let loginViewController = storyboard.instantiateViewController(
      withIdentifier: "LoginViewController") as? LoginViewController
    let loginViewModel = LoginViewModel.init()
    // set coordinator to the viewModel
    loginViewModel.coordinator = self
    // set viewModel to viewController
    loginViewController?.viewModel = loginViewModel
    // push it
    navigationController.pushViewController(loginViewController!, animated: true)
  }
  func goToRegisterPage() {
    let registerViewController = storyboard.instantiateViewController(
      withIdentifier: "RegisterViewController") as? RegisterViewController
    let registerViewModel = RegisterViewModel.init()
    registerViewModel.coordinator = self
    registerViewController?.viewModel = registerViewModel
    navigationController.pushViewController(registerViewController!, animated: true)
  }
}
