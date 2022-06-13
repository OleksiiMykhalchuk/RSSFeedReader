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
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted(primaryKey: true) var pubDate = ""
}

class RSSUrl: Object {
    @Persisted var url = ""
    @Persisted(primaryKey: true) var id = ""
}

class LastDate: Object {
    @objc dynamic var lastDate = ""
    override static func primaryKey() -> String? {
        return "lastDate"
    }
}
