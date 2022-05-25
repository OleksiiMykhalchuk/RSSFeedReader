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
  }
}
