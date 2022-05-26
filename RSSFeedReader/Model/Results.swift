//
//  DataModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class Results {
  var results = [["": ""]]
  var dictionary = ["": ""]
  var currentValue = ""
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
