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
      let viewModel = ListViewController.ViewModel()
      viewModel.coordinator = self
      let viewController = ListViewController.make(viewModel: viewModel)
      (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
  }
    func goToDetailsPage(with data: RSSItem) {
        let viewModel = DetailsViewController.ViewModel()
        viewModel.coordinator = self
        viewModel.viewModel(with: data)
        let viewController = DetailsViewController.make(viewModel: viewModel)
        (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
    func goToSettingsPage() {
        let viewModel = SettingsViewController.ViewModel()
        viewModel.coordinator = self
        let viewController = SettingsViewController.make(viewModel: viewModel)
//        viewController.modalPresentationStyle = .automatic
//        viewController.modalTransitionStyle = .flipHorizontal
        (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
}
