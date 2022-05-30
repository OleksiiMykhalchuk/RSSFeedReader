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
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print("DataBase Error \(error)")
        }
    }
}
