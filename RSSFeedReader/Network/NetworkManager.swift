//
//  NetworkManager.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

final class NetworkManager {
    private let url: String
    private lazy var xmlManager: XMLManager = XMLManager()
    init(with url: String) {
        self.url = url
    }
    enum NetworkManagerError: Error {
        case emptyData
    }
    func fetch(completion: @escaping (Swift.Result<[RSSItem], Error>) -> Void) {
        let session = URLSession.shared
        guard let urlFromString = URL(string: url) else {
            return
        }
        let dataTask = session.dataTask(with: urlFromString) { [weak self] data, _, error in
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
            let items = self?.xmlManager.parse(data: data, url: self!.url) ?? []
            DispatchQueue.main.async {
                completion(.success(items))
            }
        }
        dataTask.resume()
//        let operation = NetworkOperation(url: url) { [weak self] data, response, error in
//            guard let self = self else { return }
//            guard let data = data else {
//                if let error = error {
//                    DispatchQueue.main.async {
//                        completion(.failure(error))
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        completion(.failure(NetworkManagerError.emptyData))
//                    }
//                }
//                return
//            }
//            let items = self.xmlManager.parse(data: data)
//            DispatchQueue.main.async {
//                completion(.success(items))
//            }
//        }
//        operation.start()
    }
}
