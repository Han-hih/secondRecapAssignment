//
//  ShopingListRepository.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/09.
//

import UIKit
import RealmSwift

protocol ShopingListRepositoryType: AnyObject {
    func createItem(_ item: ShoppingTable)
    func removeItem(_ item: ShoppingTable)
    func updateItem(productId: String, image: String, name: String?, title: String, price: String)
}

class ShopingListRepository: ShopingListRepositoryType {
    
    static let shared = ShopingListRepository()
    private let realm = try! Realm()
    private init() { }
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func createItem(_ item: ShoppingTable) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(item, update: .modified) //없다면 add하고 기본키가 같다면 update한다
            }
        } catch {
            print(error)
        }
    }
    
    func removeItem(_ item: ShoppingTable) {
//        print(realm.configuration.fileURL)
        do {
            guard let task = realm.objects(ShoppingTable.self).filter({ $0.productId == item.productId }).first else { return }
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print(error)
        }
    }
    
    func updateItem(productId: String, image: String, name: String?, title: String, price: String) {
        do {
            try realm.write {
                
                realm.create(ShoppingTable.self, value: ["productId": productId, "productImage": image, "mallName": name ?? "네이버 쇼핑" , "productTitle": title, "price": price], update: .modified)
            }
        } catch {
            print("dddd")
        }
    }
}
