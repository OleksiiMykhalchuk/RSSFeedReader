//
//  DataBase.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/29/22.
//

import Foundation
import RealmSwift

class DataBaseManager {
    func sync(_ items: [RSSItem], completion: @escaping (Swift.Result<Void, Error>) -> Void) throws {
        let realm = try Realm()
        realm.writeAsync({
            let results = realm.objects(DataBaseObject.self)
            let existedItems = results.map {
                RSSItem(title: $0.title, description: $0.description, pubDate: $0.pubDate) }
            let newItems = items.filter { !existedItems.contains($0) }
            let newDataBaseItem: [DataBaseObject] = newItems.map {
                let dataBaseItem = DataBaseObject()
                dataBaseItem.title = $0.title
                dataBaseItem.desc = $0.description
                dataBaseItem.pubDate = $0.pubDate
                return dataBaseItem
            }
            realm.add(newDataBaseItem, update: .modified)
        }, onComplete: { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    func fetchData() throws -> [DataBaseObject] {
        let realm = try Realm()
        let results = realm.objects(DataBaseObject.self)
        let objects = Array(results) as [DataBaseObject]
        return objects
    }
    func saveLink(_ item: RSSUrl, completion: @escaping (Swift.Result<Void, Error>) -> Void ) throws {
        let realm = try Realm()
        realm.writeAsync({
            realm.add(item)
        }, onComplete: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
        })
    }
    func fetchLink() throws -> [RSSUrl] {
        let realm = try Realm()
        let results = realm.objects(RSSUrl.self)
        let objects = Array(results) as [RSSUrl]
        return objects
    }
}
