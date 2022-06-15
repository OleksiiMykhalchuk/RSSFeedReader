//
//  DataBaseObject.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/30/22.
//

import Foundation
import RealmSwift
import Realm

class DataBaseObject: Object {
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var pubDate = ""
    override static func primaryKey() -> String? {
        return "pubDate"
    }
}

class RSSUrl: Object {
    @Persisted var url = ""
    @Persisted(primaryKey: true) var id = ""
}
