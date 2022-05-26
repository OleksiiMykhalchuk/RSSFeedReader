//
//  DataModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class Results {
  var results: [[String: String]]?
  var dictionary: [String: String]?
  var currentValue: String?
  var rss = false
  var channel = false
  var item = false
  var dictionaryKeys = [ "title",
                         "link",
                         "description",
                         "content:encoded",
                         "pubDate",
                         "guid" ]
  deinit {
    print("Results deinit")
  }
}
