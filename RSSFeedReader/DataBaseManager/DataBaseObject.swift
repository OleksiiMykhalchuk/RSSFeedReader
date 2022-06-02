//
//  DataBaseObject.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/30/22.
//

import Foundation
import RealmSwift


class DataBaseObject: Object {
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var isNew = true
    @Persisted var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}

