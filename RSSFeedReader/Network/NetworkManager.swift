//
//  NetworkManager.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

final class NetworkManager: NSObject {
  private let url: URL
  var items: [RSSItem] = []
  var item: RSSItem!
  var rss = false
  var channel = false
  var itemBool = false
  var currentValue: String!
  var title: String!
  var descript: String!
  var titleIsPresent = false
  var descriptIsPresent = false
  init(with url: URL) {
    self.url = url
  }
  func fetch(completion: @escaping (Swift.Result<[RSSItem], Error>) -> Void) throws {
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url) { data, response, error in
      if let error = error as NSError?, error.code == -999 {
        print("Data Task Error \(error)")
        completion(.failure(error))
        return
      }
      if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        completion(.success(self.items))
      }
    }
    dataTask.resume()
  }
}
