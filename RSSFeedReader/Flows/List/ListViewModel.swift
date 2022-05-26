//
//  ListViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

extension ListViewController {
    class ListViewModel {
      weak var coordinator: AppCoordinator?
        var itemNumber: Int  {
            dataSource.count
        }
        private var dataSource: [NetworkManager.RSSItem] = []
        var reloadData: Bindable<Void> = .init(nil)
        func start() {
            // do network request here
            // update dataSource
            // call reloadData
        }
        
        func cellViewModel(for index: Int) -> ListCellViewModel {
            let rssItem = dataSource[index]
            return .init(title: rssItem.title)
        }

    //  func goToList() {
    //    coordinator?.goToListPage()
    //  }
    }
}
