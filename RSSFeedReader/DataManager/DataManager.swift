//
//  DataManager.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/30/22.
//

import Foundation

class DataManager {
    var dataSource: [NetworkManager.RSSItem] = []
    var objects: [DataBaseObject] = []
    var reloadData: Bindable<Void> = .init(nil)
    var networkManager: NetworkManager!
    var dataBaseManager: DataBaseManager!
    var state: NetworkManager.State = .loading
    func getData() -> [NetworkManager.RSSItem] {
        let url = URL(string: "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer&sort=recency")
        networkManager = NetworkManager(with: url!)
        dataBaseManager = DataBaseManager()
        networkManager.fetch { [weak self] results in
            switch results {
            case .success(let data):
                self?.dataSource = data
                let objects = self?.networkManager.xmlManager.getObject()
                self?.dataBaseManager.writeData(objects: objects!)
                DispatchQueue.main.async {
                    self?.state = (self?.networkManager.state)!
                    self?.reloadData.update(with: ())
                }
            case .failure(let error):
                print("NetworkManager Error \(error)")
            }
        }
        return dataSource
    }

}
