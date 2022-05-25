//
//  Coordinator.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation
import UIKit

protocol CoordinatorExample {

  var parentCoordinator: CoordinatorExample? { get set }
  var children: [CoordinatorExample] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}
