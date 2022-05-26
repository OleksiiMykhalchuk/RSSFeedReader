//
//  LoadData.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import Foundation

class LoadData: NSObject {
  private var dataTask: URLSessionDataTask?

  func loadData() {
    let urlString = "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer"
    let url = URL(string: urlString)!
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url) { data, response, error in
      self.parse(data: data!)
    }
    dataTask.resume()
  }
  func parse(data: Data) {
      let parser = XMLParser(data: data)
      parser.delegate = self
      parser.parse()
  }
  var results: [[String: String]]?
  var currentDictionary: [String: String]?
  var currentValue: String?
  var rssChannel = ["rss", "channel"]
  var dictionaryKeys = ["title", "link", "description", "language", "pubDate", "copyright", "docs", "generator", "manageingEditor", "image", "url"]

}
extension LoadData: XMLParserDelegate {

  func parserDidStartDocument(_ parser: XMLParser) {
    results = []
  }
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    if "item" == elementName {
      currentDictionary = [:]
    } else if dictionaryKeys.contains(elementName) {
      currentValue = ""
    }
  }
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if "item" == elementName {
      results?.append(currentDictionary!)
      currentDictionary = nil
    } else if dictionaryKeys.contains(elementName) {
      currentDictionary?[elementName] = currentValue
      currentValue = nil
    }
  }
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    print("Parse Error \(parseError)")
  }
  func parserDidEndDocument(_ parser: XMLParser) {
    print(results)
  }
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    currentValue? += string
  }
}
