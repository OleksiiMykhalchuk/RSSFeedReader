//
//  DataBase.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/29/22.
//

import Foundation
import RealmSwift

class DataBaseManager {
    enum DataBaseError: Error {
        case deleteLinkError, deleteObjectError
    }
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
            realm.add(newDataBaseItem, update: .all)
            let lastDate = LastDate()
            let existedItemsSorted = existedItems.sorted { lhs, rhs in
                lhs.pubDate > rhs.pubDate
            }
            lastDate.lastDate = existedItemsSorted.first.map { $0.pubDate }!
            realm.add(lastDate, update: .modified)
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
    func deleteItem(_ item: RSSItem, completion: @escaping (Swift.Result<Void, Error>) -> Void) throws {
        let realm = try Realm()
        try realm.write {
            let object = realm.object(ofType: DataBaseObject.self, forPrimaryKey: item.pubDate)
            if let object = object {
                realm.delete(object)
                completion(.success(()))
            } else {
                completion(.failure(DataBaseError.deleteObjectError))
            }
        }
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
    func deleteLink(_ item: RSSUrl, completion: (Swift.Result<Void, Error>) -> Void) throws {
        let realm = try Realm()
        try realm.write {
            let object = realm.object(ofType: RSSUrl.self, forPrimaryKey: item.id)
            if let object = object {
                realm.delete(object)
                completion(.success(()))
            } else {
                completion(.failure(DataBaseError.deleteLinkError))
            }
        }
    }
    func fetchLastDate() throws -> String {
        let realm = try Realm()
        let results = realm.objects(LastDate.self)
        return results.last?.lastDate ?? ""
    }
}
