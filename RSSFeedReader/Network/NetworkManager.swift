//
//  NetworkManager.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

final class NetworkManager {
    private let url: URL
    private lazy var xmlManager: XMLManager = XMLManager()
    init(with url: URL) {
        self.url = url
    }
    enum NetworkManagerError: Error {
        case emptyData
    }
    func fetch(completion: @escaping (Swift.Result<[RSSItem], Error>) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkManagerError.emptyData))
                    }
                }
                return
            }
            let items = self?.xmlManager.parse(data: data) ?? []
            DispatchQueue.main.async {
                completion(.success(items))
            }
        }
        dataTask.resume()
    }
}
