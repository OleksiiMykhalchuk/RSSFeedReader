//
//  NetworkManager.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

final class NetworkManager {
    private let url: URL
    
    init(with url: URL) {
        self.url = url
    }
    
    func fetch(completion: (Swift.Result<RSSItem, Error>) -> Void) throws {
        
    }
}
