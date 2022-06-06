//
//  DataManager.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/30/22.
//

import Foundation

class DataManager {
    private lazy var dataBase: DataBaseManager = .init()
    private lazy var networkManager: NetworkManager = .init(
        with: URL(
            string: "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer&sort=recency&paging=0%3B50")!)
    func fetchData() -> [RSSItem] {
        do {
            let items = try dataBase.fetchData()
            return items.map { RSSItem(title: $0.title, description: $0.desc, pubDate: $0.pubDate)}
        } catch {
            print("Read Data Error \(error)")
        }
        return []
    }
    func refreshData(_ completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        networkManager.fetch { [weak self] result in
            switch result {
            case .success(let newItems):
                do {
                    try self?.dataBase.sync(newItems, completion: completion)
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
