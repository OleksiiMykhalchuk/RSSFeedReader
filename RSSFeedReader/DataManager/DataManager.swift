//
//  DataManager.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/30/22.
//

import Foundation

class DataManager {
    var dataSource: [RSSItem] = []
    var dataBaseSource: [DataBaseObject] = []
    var objects: [DataBaseObject] = []
    var reloadData: Bindable<Void> = .init(nil)
    var networkManager: NetworkManager!
    var dataBaseManager: DataBaseManager!
    var state: NetworkManager.State = .loading
    var status: NetworkManager.Status = .normal
    func getData() -> [RSSItem] {
        DispatchQueue.main.async {
            let url = URL(
                string: "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer&sort=recency&paging=0%3B50")
            self.networkManager = NetworkManager(with: url!)
            self.dataBaseManager = DataBaseManager()
            self.networkManager.fetch { [weak self] results in
                switch results {
                case .success(let data):
                    self?.dataSource = data
                    let objects = self?.networkManager.xmlManager.getObject()
                    self?.dataBaseManager.writeData(objects: objects!)
                    self?.dataBaseSource = (self?.dataBaseManager.readData())!
                    DispatchQueue.main.async {
                        self?.state = (self?.networkManager.state)!
                        self?.reloadData.update(with: ())
                    }
                case .failure(let error):
                    print("NetworkManager Error \(error)")
                    DispatchQueue.main.async {
                        self?.state = (self?.networkManager.state)!
                        self?.reloadData.update(with: ())
                    }
                }
            }
        }
        return dataSource
    }
    func getDataBase() -> [DataBaseObject] {
        let dataBase = DataBaseManager()
        let data = dataBase.readData()
        return data
    }
}
