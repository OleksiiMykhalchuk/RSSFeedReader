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
    let url = "https://www.upwork.com/ab/feed/jobs/rss?q=mobile+developer"
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url, completionHandler: { data, response, error in })
    dataTask.resume()
  }
  func parse(data: Data) -> [Result] {
      let parser = XMLParser(data: data)
      parser.delegate = self
      parser.parse()
  }
}
extension LoadData: XMLParserDelegate {

  func parserDidStartDocument(_ parser: XMLParser) {

  }
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

  }
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

  }
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    
  }
  func parserDidEndDocument(_ parser: XMLParser) {

  }
  func parser(_ parser: XMLParser, foundCharacters string: String) {

  }
}
