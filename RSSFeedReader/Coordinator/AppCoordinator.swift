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
  let rootViewController: UIViewController

  init(_ navigationController: UINavigationController) {
    self.rootViewController = navigationController
  }

  func start() {
    goToListPage()
  }
  func goToListPage() {
      let viewModel = ListViewController.ListViewModel()
      viewModel.coordinator = self
      let viewController = ListViewController.make(viewModel: viewModel)
      (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
  }
}
