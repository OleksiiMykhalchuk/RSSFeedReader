//
//  DataOperation.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/16/22.
//

import Foundation

typealias Complete = (Swift.Result<Void, Error>) -> Void

class DataOperation: Operation {
    private var dataBase: DataBaseManager
    private var networkManager: NetworkManager
    private var source: String
    private var completion: Complete
    init(source: String, dataBase: DataBaseManager, networkManager: NetworkManager, completion: @escaping Complete) {
        self.dataBase = dataBase
        self.networkManager = networkManager
        self.completion = completion
        self.source = source
    }
    override func start() {
        main()
    }
    override func main() {
        networkManager.fetch { [weak self] result in
            switch result {
            case .success(let items):
                do {
                    try self?.dataBase.sync(items, source: self!.source, completion: self!.completion)
                } catch {
                    print("Error Sync Data Base in Operation \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Network Manager Fetch Error Operation \(error.localizedDescription)")
            }
        }
    }
}
