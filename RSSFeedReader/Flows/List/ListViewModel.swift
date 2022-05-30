//
//  ListViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation
import UIKit

extension ListViewController {
    class ViewModel {
        weak var coordinator: AppCoordinator?
        var itemNumber: Int {
            dataSource.count
        }
        var dataManager: DataManager!
        private var dataSource: [NetworkManager.RSSItem] = []
        var reloadData: Bindable<Void> = .init(nil)
        func start() {
            dataManager = DataManager()
            dataSource = dataManager.getData()
            dataManager.reloadData.bind(to: self) { [weak self] _ in
                self?.dataSource = (self?.dataManager.dataSource)!
                self?.reloadData.update(with: ())
            }
        }
        func cellViewModel(for index: Int) -> ListCellViewModel {
            let rssItem = dataSource[index]
            return .init(title: rssItem.title, description: rssItem.description)
        }
        func didSelectItem(with index: Int) -> ListCellViewModel {
            let rssItem = dataSource[index]
            return .init(title: rssItem.title, description: rssItem.description)
        }
        func isLoading() -> NetworkManager.State {
            return dataManager.state
        }
    }
}
