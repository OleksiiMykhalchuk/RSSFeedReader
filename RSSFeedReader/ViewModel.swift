//
//  ViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class LoginViewModel {
  weak var coordinator: AppCoordinatorExample?
  func goToRegister() {
    coordinator?.goToRegisterPage()
  }
}

class RegisterViewModel {
  weak var coordinator: AppCoordinatorExample?
  func goToLogin() {
    coordinator?.goToLoginPage()
  }
}
