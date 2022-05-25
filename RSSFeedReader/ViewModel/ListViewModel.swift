//
//  ListViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class ListViewModel {
  weak var coordinator: AppCoordinator?
  func goToList() {
    coordinator?.goToListPage()
  }
}
