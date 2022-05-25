//
//  DataModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class Results: Codable {
  var resultCount = 0
  var results: [Result] = []
}

class Result: Codable {
  var title = ""
}
