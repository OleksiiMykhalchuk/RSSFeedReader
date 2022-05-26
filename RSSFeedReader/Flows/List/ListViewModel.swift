//
//  ListViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class ListViewModel {
  weak var coordinator: AppCoordinator?
    private(set) var itemNumber: Int = 0
    var reloadData: Bindable<Void> = .init(nil)
    func start() {
    }
    
    func cellViewModel(for index: Int) -> ListCellViewModel {
        // your code here
        return .init()
    }

//  func goToList() {
//    coordinator?.goToListPage()
//  }
}
