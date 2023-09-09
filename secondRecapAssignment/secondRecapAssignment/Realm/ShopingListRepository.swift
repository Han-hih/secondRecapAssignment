//
//  ShopingListRepository.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/09.
//

import UIKit
import RealmSwift

protocol ShopingListRepositoryType: AnyObject {
    func updateItem(id: ObjectId, image: String, name: String, title: String, price: String, like: Bool)
}

class ShopingListRepository: ShopingListRepositoryType {
    
    private let realm = try! Realm()
    func updateItem(id: ObjectId, image: String, name: String, title: String, price: String, like: Bool) {
        do {
            try realm.write {
                
                realm.create(ShoppingTable.self, value: ["_id": id, "productImage": image, "mallName": name, "productTitle": title, "price": price, "like": like ], update: .modified)
            }
        } catch {
            print("dddd")
        }
    }
}
