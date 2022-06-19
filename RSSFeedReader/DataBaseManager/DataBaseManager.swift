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
    func sync(_ items: [RSSItem], source: String, completion: @escaping (Swift.Result<Void, Error>) -> Void) throws {
        let realm = try Realm()
        realm.writeAsync({
            let results = realm.objects(DataBaseObject.self)
            let existedItems = results.map {
                RSSItem(title: $0.title, description: $0.desc, pubDate: $0.pubDate, source: $0.source) }
            let newItems = items.filter { !existedItems.contains($0) }
            let newDataBaseItem: [DataBaseObject] = newItems.map {
                let dataBaseItem = DataBaseObject()
                dataBaseItem.title = $0.title
                dataBaseItem.desc = $0.description
                dataBaseItem.pubDate = $0.pubDate
                dataBaseItem.source = source
                return dataBaseItem
            }
            realm.add(newDataBaseItem)
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
    func deleteData(with link: String) throws {
        let realm = try Realm()
        try realm.write {
            let objects = realm.objects(DataBaseObject.self)
            let objectsWithLink = objects.where {
                $0.source == link
            }
            realm.delete(objectsWithLink)
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
}
