//
//  LinkOperation.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/14/22.
//

import UIKit
typealias CompletionURL = ((Data?, URLResponse?, Error?) -> Void)?

final class NetworkOperation: Operation {
    var item: RSSItem?
    private let url: URL
    private lazy var xmlManager: XMLManager = XMLManager()
    private let completion: CompletionURL
    private static let context = CIContext()
    enum State: String {
        case ready, executing, finished

        fileprivate var keyPath: String {
            return "is \(rawValue.capitalized)"
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
        return state == .finished
    }
    override var isAsynchronous: Bool {
        return true
    }
    init(url: URL, completion: CompletionURL = nil) {
        self.url = url
        self.completion = completion
        super.init()
    }
    override func main() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.state = .finished }
            if let completion = self.completion {
                completion(data, response, error)
                return
            }
        }.resume()
    }
    override func start() {
        main()
        state = .executing
    }
}

