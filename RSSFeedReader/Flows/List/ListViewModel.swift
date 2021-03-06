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
            case inProgress, finish, failure, noLinks, empty
        }
        weak var coordinator: AppCoordinator?
        var itemsNumber: Int {
            if dataSource.isEmpty {
                updateStatusData.update(with: .empty)
                return 0
            } else {
                return dataSource.count
            }
        }
        private var oldPubDate: String!
        private lazy var dataManager: DataManager = .init()
        private var dataSource: [RSSItem] = []
        private var errorCollection: [ErrorCollection] = []
        let reloadData: Bindable<Void> = .init(nil)
        let updateStatusData: Bindable<UpdateState> = .init(nil)
        func start() {
            refreshDataSource()
            startUpdate()
        }
        func startUpdate() {
            updateStatusData.update(with: .inProgress)
            dataManager.refreshData { [weak self] result in
                switch result {
                case .success(()):
                    self?.refreshDataSource()
                    self?.updateStatusData.update(with: .finish)
                    self?.errorCollection = self?.dataManager.fetchError() ?? []
                case .failure(let error):
                    if error as? DataManager.DataError == DataManager.DataError.emptyLinkData {
                        self?.updateStatusData.update(with: .noLinks)
                    } else {
                        self?.updateStatusData.update(with: .failure)
                        print("****\(error)")
                    }
                }
            }
            print("****** Start Update")
        }
        func ifUrlFailed() -> [ErrorCollection] {
            return errorCollection 
        }
        func cellViewModel(for index: Int) -> RSSItem {
            let rssItem = dataSource[index]
            return rssItem
        }
        func cellViewIfNew(for index: Int) -> Bool {
            let rssItem = dataSource[index]
            if let lastDate = oldPubDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
                guard let rssDate = formatter.date(from: rssItem.pubDate) else { return false }
                guard let last = formatter.date(from: lastDate) else { return false }
                return rssDate.compare(last) == ComparisonResult.orderedDescending
            } else {
                return true
            }
        }
        func saveOldViewDate() {
            oldPubDate = UserDefaults.standard.object(forKey: "pubDate") as? String
        }
        func saveLastViewDate() {
            UserDefaults.standard.set(dataSource.first?.pubDate, forKey: "pubDate")
            print("LastDateSaved")
        }
        private func refreshDataSource() {
            dataSource = dataManager.fetchData()
            errorCollection = dataManager.fetchError() ?? []
            reloadData.update(with: ())
        }
    }
}
