//
//  XMLParser.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/27/22.
//

import Foundation

class XMLManager: NSObject, XMLParserDelegate {
    private var items: [RSSItem] = []
    private var item: RSSItem!
    private var objects: [DataBaseObject] = []
    private var object: DataBaseObject!
    private var rss = false
    private var channel = false
    private var itemBool = false
    private var currentValue: String!
    private var title: String!
    private var descript: String!
    private var pubDate: String!
    private var titleIsPresent = false
    private var descriptIsPresent = false
    private var data: Data!
    deinit {
        print("XML Manager deinit{}")
    }
    func parse(data: Data) -> [RSSItem] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return items
    }
    func getObject() -> [DataBaseObject] {
        return objects
    }
    internal func parserDidStartDocument(_ parser: XMLParser) {
        print("start")
    }
    internal func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]) {
        if elementName == "rss" {
            rss = true
        } else if elementName == "channel" {
            channel = true
        } else if elementName == "item" {
            itemBool = true
            currentValue = ""
            title = ""
            descript = ""
            pubDate = ""
        }
    }
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue = string
    }
    internal func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?) {
        if elementName == "item" {
            items.append(.init(title: title, description: descript, pubDate: pubDate))
            object = DataBaseObject()
            object.title = title
            object.desc = descript
            object.pubDate = pubDate
            objects.append(object)
        } else if elementName == "title", rss, channel, itemBool {
            title = currentValue
            titleIsPresent = true
        } else if elementName == "description", rss, channel, itemBool {
            descript = currentValue
            descriptIsPresent = true
        } else if elementName == "pubDate", rss, channel, itemBool {
            pubDate = currentValue
        }
    }
    internal func parserDidEndDocument(_ parser: XMLParser) {
        print("EndDocument")
        rss = false
        channel = false
        itemBool = false
    }
}
