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
            case inProgress, finish, failure
        }
        weak var coordinator: AppCoordinator?
        var itemsNumber: Int {
            dataSource.count
        }
        private var oldPubDate: String!
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
            dataManager.refreshData { [weak self] result in
                switch result {
                case .success(()):
                    self?.updateStatusData.update(with: .finish)
                    self?.refreshDataSource()
                case .failure(let error):
                    self?.updateStatusData.update(with: .failure)
                }
            }
        }
        func cellViewModel(for index: Int) -> RSSItem {
            let rssItem = dataSource[index]
            return rssItem
        }
        func cellViewIfNew(for index: Int) -> Bool {
            let rssItem = dataSource[index]
            if let lastDate = oldPubDate {
                print("\(String(describing: lastDate))")
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
            reloadData.update(with: ())
        }
    }
}
