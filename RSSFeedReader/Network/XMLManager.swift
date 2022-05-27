//
//  XMLParser.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/27/22.
//

import Foundation

class XMLMannager: NSObject, XMLParserDelegate {
    private var items: [NetworkManager.RSSItem] = []
    private var item: NetworkManager.RSSItem!
    private var rss = false
    private var channel = false
    private var itemBool = false
    private var currentValue: String!
    private var title: String!
    private var descript: String!
    private var titleIsPresent = false
    private var descriptIsPresent = false
    private var data: Data!
    init(data: Data) {
        self.data = data
    }
    deinit {
        print("XML Manager deinit{}")
    }
    func parse() -> [NetworkManager.RSSItem]{
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return items
    }
    internal func parserDidStartDocument(_ parser: XMLParser) {
        print("start")
    }
    internal func parser(_ parser: XMLParser,
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
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue = string
    }
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
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
    internal func parserDidEndDocument(_ parser: XMLParser) {
        print("EndDocument")
        rss = false
        channel = false
        itemBool = false
    }
}
