//
//  SettingsViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/7/22.
//

import Foundation
import SwiftUI

extension SettingsViewController {
    class ViewModel {
        weak var coordinator: AppCoordinator?
        private lazy var dataManager: DataManager = .init()
        private var dataSource: [RSSUrl] = []
        let reloadData: Bindable<Void> = .init(nil)
        var itemsNumber: Int {
            dataSource.count
        }
        func start() {
            fetchData()
        }
        func save(url: String, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
            let rssURL = RSSUrl()
            rssURL.id = UUID().uuidString
            rssURL.url = url
            dataManager.saveLink(rssURL, copmletion: completion)
        }
        private func fetchData() {
            dataSource = dataManager.fetchLink()
        }
        func refreshData() {
            fetchData()
            reloadData.update(with: ())
        }
        func cellViewModel(for index: Int) -> RSSUrl {
            let rssLink = dataSource[index]
            return rssLink
        }
        func deleteLink(for index: Int) {
            let rssLink = dataSource[index]
            let url = rssLink.url
            dataManager.deleteDBData(with: rssLink.url) { result in
                switch result {
                case .success(_):
                    print("Content of URL  deleted")
                case .failure(let error):
                    print("Error deleteting URL content, error is \(error.localizedDescription)")
                }
            }
            dataManager.deleteLink(item: rssLink)
            UserDefaults.standard.removeObject(forKey: "pubDate")
            UserDefaults.standard.removeObject(forKey: url)
        }

    }
}
