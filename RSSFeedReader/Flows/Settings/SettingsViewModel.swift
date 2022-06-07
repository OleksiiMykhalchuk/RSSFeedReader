//
//  SettingsViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/7/22.
//

import Foundation

extension SettingsViewController {
    class ViewModel {
        weak var coordinator: AppCoordinator?
        private lazy var dataManager: DataManager = .init()
        private var dataSource: [RSSUrl] = []
        var itemsNumber: Int {
            dataSource.count
        }
        func start() {

        }
        func save(url: String) {
            var rssURL = RSSUrl()
            rssURL.id = UUID().uuidString
            rssURL.url = url
            dataManager.saveLink(rssURL)
        }
        private func fetchData() {
            dataSource = dataManager.fetchLink()
        }
        func cellViewModel(for index: Int) -> RSSUrl {
            let rssLink = dataSource[index]
            return rssLink
        }
    }
}
