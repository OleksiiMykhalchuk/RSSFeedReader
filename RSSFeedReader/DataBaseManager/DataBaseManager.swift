//
//  DataBase.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/29/22.
//

import Foundation
import RealmSwift

class DataBaseManager {
    func writeData(objects: [DataBaseObject]) {
        do {
            let realm = try Realm()
                let old = realm.objects(DataBaseObject.self)
                compareObjects(old: old, new: objects)
                try realm.write {
                    realm.deleteAll()
                    realm.add(objects, update: .modified)
            }
        } catch {
            print("DataBase Error \(error)")
        }
    }
    func readData() -> [DataBaseObject] {
        do {
            let realm = try Realm()
            let results = realm.objects(DataBaseObject.self)
            let objects = Array(results) as [DataBaseObject]
            return objects
        } catch {
            print("Read DataBase Error \(error)")
        }
        return []
    }
    private func compareObjects(old: Results<DataBaseObject>, new: [DataBaseObject]) {
        old.sorted { lhs, rhs in
            return lhs.pubDate > rhs.pubDate
        }
        new.sorted { lhs, rhs in
            return lhs.pubDate > rhs.pubDate
        }
        for old in old {
            for new in new {
                if old.pubDate == new.pubDate {
                    new.isNew = false
                    continue
                }
            }
        }
    }
}
