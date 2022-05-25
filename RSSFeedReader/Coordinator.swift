//
//  Coordinator.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation
import UIKit

protocol Coordinator {

  var parentCoordinator: Coordinator? { get set }
  var children: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}
