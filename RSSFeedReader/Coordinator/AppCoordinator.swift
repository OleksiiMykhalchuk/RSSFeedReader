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
  var navigationController: UINavigationController?

  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    goToListPage()
  }
  func goToListPage() {
    let listViewController = ListViewController(nibName: "ListViewController", bundle: nil)
    let listViewModel = ListViewModel()
    listViewModel.coordinator = self
    listViewController.viewModel = listViewModel
    navigationController?.pushViewController(listViewController, animated: true)
  }
}
