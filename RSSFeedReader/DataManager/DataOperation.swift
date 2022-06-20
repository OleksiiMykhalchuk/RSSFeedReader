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
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .executing
    }
    override var isAsynchronous: Bool {
        return true
    }
    init(source: String, dataBase: DataBaseManager, networkManager: NetworkManager, completion: @escaping Complete) {
        self.dataBase = dataBase
        self.networkManager = networkManager
        self.completion = completion
        self.source = source
    }
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    override func cancel() {
        super.cancel()
        networkManager.cancel()
        print("*****cancel()")
    }
    override func main() {
        networkManager.fetch { result in
            switch result {
            case .success(let items):
                do {
                    try self.dataBase.sync(items, source: self.source, completion: self.completion)
                } catch {
                    print("Error Sync Data Base in Operation \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Network Manager Fetch Error Operation \(error.localizedDescription)")
                    self.completion(.failure(error))
            }
        }
    }
}
