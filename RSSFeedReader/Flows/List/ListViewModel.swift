//
//  ListViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

extension ListViewController {
    class ViewModel {
        weak var coordinator: AppCoordinator?
        var itemNumber: Int {
            dataSource.count
        }
        private var dataSource: [NetworkManager.RSSItem] = []
        var reloadData: Bindable<Void> = .init(nil)
        func start() {
            // do network request here
            // update dataSource
            // call reloadData
            let url = URL(string: "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer")
            let networkManager = NetworkManager(with: url!)
               networkManager.fetch(completion: { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.dataSource = data
                        DispatchQueue.main.async {
                            self?.reloadData.update(with: ())
                        }
                    case .failure(let error):
                        print(error)
                    }
                })
        }
        func cellViewModel(for index: Int) -> ListCellViewModel {
            let rssItem = dataSource[index]
            return .init(title: rssItem.title, description: rssItem.description)
        }
    }
}
