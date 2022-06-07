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
        enum UpdateState {
            case inProgress
            case finish
        }
        weak var coordinator: AppCoordinator?
        var itemsNumber: Int {
            dataSource.count
        }
        private lazy var dataManager: DataManager = .init()
        private var dataSource: [RSSItem] = []
        let reloadData: Bindable<Void> = .init(nil)
        let updateStatusData: Bindable<UpdateState> = .init(nil)
        func start() {
            refreshDataSource()
            startUpdate()
        }
        func startUpdate() {
            updateStatusData.update(with: .inProgress)
            dataManager.refreshData { [weak self] _ in
                self?.updateStatusData.update(with: .finish)
                self?.refreshDataSource()
            }
        }
        func cellViewModel(for index: Int) -> RSSItem {
            let rssItem = dataSource[index]
            return rssItem
        }
        func cellViewIfNew(for index: Int) -> Bool {
            let rssItem = dataSource[index]
            let defaults = UserDefaults.standard
            let lastDate = defaults.object(forKey: "lastDate") as? String
            if index == 0 {
                defaults.set(rssItem.pubDate, forKey: "lastDate")
            }
            if let lastDate = lastDate, lastDate < rssItem.pubDate, !dataSource.isEmpty {
                return true
            } else {
                return false
            }
        }
        private func refreshDataSource() {
            dataSource = dataManager.fetchData()
            reloadData.update(with: ())
        }
    }
}
