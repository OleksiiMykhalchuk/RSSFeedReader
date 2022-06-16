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
            string: "http://localhost/xml/xampp.xml")!)
    private lazy var urls: [String] = {
        let items = fetchLink()
        let array = Array(items) as [RSSUrl]
        let urls: [String] = array.map { $0.url }
        return urls
    }()
//    "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer&sort=recency&paging=0%3B10"
//https://www.upwork.com/ab/feed/jobs/rss?q=python&sort=recency&paging=0%3B10
    /*
     https://www.ledsign.com.ua/test.xml
     URL(
         string: "http://localhost/xml/xampp.xml")!)
     */
    enum DataError: Error {
        case emptyLinkData
    }
    func fetchData() -> [RSSItem] {
        do {
            let items = try dataBase.fetchData()
            let itemsSorted = items.sorted { lhs, rhs in
                rhs.pubDate < lhs.pubDate}
            return itemsSorted.map { RSSItem(title: $0.title, description: $0.desc, pubDate: $0.pubDate, source: $0.source)}
        } catch {
            print("Read Data Error \(error)")
        }
        return []
    }
    func refreshData(_ completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        let urls = linkToString()
        if !urls.isEmpty {
            for index in 0..<urls.count {
                let urlString = urls[index]
                if let url = URL(string: urlString) {
                    let networkManager = NetworkManager(with: url)
                    let operation = DataOperation(
                        source: urlString,
                        dataBase: dataBase,
                        networkManager: networkManager,
                        completion: completion)
                    let operationQueue = OperationQueue()
                    operationQueue.addOperation(operation)
                }
            }
        } else {
            completion(.failure(DataError.emptyLinkData))
        }
    }
    func saveLink(_ item: RSSUrl, copmletion: @escaping (Swift.Result<Void, Error>) -> Void) {
        do {
           try dataBase.saveLink(item, completion: { result in
                switch result {
                case .success(_):
                    print("Link Saved")
                    copmletion(.success(()))
                case .failure(let error):
                    print("Error Saving")
                    copmletion(.failure(error))
                }
            })
        } catch {
            print("DataBase Error")
        }
    }
    func fetchLink() -> [RSSUrl] {
        do {
            let items = try dataBase.fetchLink()
            return items
        } catch {
            print("Error Fetching the Links")
        }
        return []
    }
    private func linkToString() -> [String] {
        let objects = fetchLink()
        let link = Array(objects) as [RSSUrl]
        let links = link.map { $0.url }
        return links
    }
    func deleteLink(item: RSSUrl) {
        do {
            try dataBase.deleteLink(item, completion: { result in
                switch result {
                case .success(_):
                    print("Link Deleted")
                case .failure(_):
                    print("Link Delete Failure")
                }
            })
        } catch {
            print("Error Data Base while Delete")
        }
    }
}
