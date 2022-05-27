//
//  XMLParser.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/27/22.
//

import Foundation

extension NetworkManager: XMLParserDelegate {
  func parserDidStartDocument(_ parser: XMLParser) {
    print("start")
  }
  func parser(_ parser: XMLParser,
              didStartElement elementName: String,
              namespaceURI: String?,
              qualifiedName qName: String?,
              attributes attributeDict: [String : String] = [:]) {
    if elementName == "rss" {
      rss = true
    } else if elementName == "channel" {
      channel = true
    } else if elementName == "item" {
      itemBool = true
      currentValue = ""
      title = ""
      descript = ""
    }
  }
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    currentValue = string
  }
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "item" {
      items.append(.init(title: title, description: descript))
    } else if elementName == "title", rss, channel, itemBool {
      title = currentValue
      titleIsPresent = true
    } else if elementName == "description", rss, channel, itemBool {
      descript = currentValue
      descriptIsPresent = true
  }
  }
  func parserDidEndDocument(_ parser: XMLParser) {
    print("EndDocument")
  }
}
