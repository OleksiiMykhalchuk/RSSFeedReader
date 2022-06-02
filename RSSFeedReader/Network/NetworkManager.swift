//
//  NetworkManager.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

final class NetworkManager {
    private let url: URL
    var xmlManager: XMLManager = XMLManager()
    enum State {
        case loading
        case loaded
        case error
    }
    enum Status {
        case response
        case error
        case normal
    }
    private(set) var status: Status = .normal
    private(set) var state: State = .loading
    init(with url: URL) {
        self.url = url
    }
    func fetch(completion: @escaping (Swift.Result<[RSSItem], Error>) -> Void) {
        state = .loading
        status = .normal
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                self?.status = .error
                self?.state = .error
                NotificationCenter.default.post(name: Notification.Name("Name"), object: error, userInfo: nil)
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Status Code is not 200: statusCode - \(response.statusCode)")
                print("Response is \(response)")
                self?.status = .response
                self?.state = .error
                NotificationCenter.default.post(name: Notification.Name("Name"), object: response)
            }
            if let data = data {
                completion(.success((self?.xmlManager.parse(data: data))!))
                self?.state = .loaded
                self?.status = .normal
            }
        }
        dataTask.resume()
    }
}
