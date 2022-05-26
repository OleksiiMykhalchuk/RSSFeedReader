//
//  LoadData.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation
import UIKit

class LoadData: NSObject {
  private var dataTask: URLSessionDataTask?

  func loadData() {
    let urlString = "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer"
    let url = URL(string: urlString)!
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url) { data, response, error in
      if let error = error as NSError?, error.code == -999 {
        print("data Task Error \(error)")
        return
      }
      if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
        self.parse(data: data)
      }
    }
    dataTask.resume()
  }
  func parse(data: Data) -> Results {
      let parser = XMLParser(data: data)
      parser.delegate = self
      parser.parse()
    return results!
  }

  var results: Results?

}
extension LoadData: XMLParserDelegate {

  func parserDidStartDocument(_ parser: XMLParser) {
    results = Results()
    results?.results = []
  }
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    if elementName == "rss" {
      results?.rss = true
    } else if elementName == "channel" {
      results?.channel = true
    } else if elementName == "item" {
      results?.item = true
      results?.dictionary = [:]
    } else if (results?.dictionaryKeys.contains(elementName))! && results!.rss && results!.channel {
      results?.currentValue = ""
    }
  }
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    results?.currentValue = string
  }
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "item" {
      results?.item = false
      results?.results?.append((results?.dictionary!)!)
    } else if (results?.dictionaryKeys.contains(elementName))! && results!.rss && results!.channel && results!.item {
      results?.dictionary![elementName] = results?.currentValue
    }
  }
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    print("Parse Error \(parseError)")
  }
  func parserDidEndDocument(_ parser: XMLParser) {
    print(results?.results)
    results?.rss = false
    results?.channel = false
    results?.item = false
  }
}
