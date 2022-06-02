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
        private var dataSource: [RSSItem] = []
        private var dataBaseSource: [DataBaseObject] = []
        var reloadData: Bindable<Void> = .init(nil)
        func start() {
            dataManager = DataManager()
            dataSource = dataManager.getData()
//            dataBaseSource = dataManager.getDataBase()
            dataManager.reloadData.bind(to: self) { [weak self] _ in
                self?.dataSource = (self?.dataManager.dataSource)!
                self?.reloadData.update(with: ())
            }
        }
        func cellViewModel(for index: Int) -> RSSItem {
            let rssItem = dataSource[index]
            return rssItem
        }
        func cellViewIfNew(for index: Int) -> Bool {
            dataBaseSource = dataManager.getDataBase()
            let object = dataBaseSource[index]
            return object.isNew
        }
        func isLoading() -> NetworkManager.State {
            return dataManager.state
        }
        func getStatus() -> NetworkManager.Status {
            return dataManager.status
        }
    }
}
