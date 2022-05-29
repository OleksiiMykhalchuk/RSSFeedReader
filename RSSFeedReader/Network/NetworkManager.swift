//
//  NetworkManager.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

final class NetworkManager{
    private let url: URL
    enum State {
        case loading
        case loaded
    }
    private(set) var state: State = .loading
    init(with url: URL) {
        self.url = url
    }
    func fetch(completion: @escaping (Swift.Result<[RSSItem], Error>) -> Void) {
        state = .loading
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
//                print("Data Task Error \(error)")
                completion(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Status Code is not 200: statusCode - \(response.statusCode)")
                print("Response is \(response)")
                return
            }
            if let data = data {
                let xmlManager = XMLMannager(data: data)
                completion(.success(xmlManager.parse()))
                self.state = .loaded
            }
        }
        dataTask.resume()
    }
}
