//
//  ShoppingTable.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/09.
//

import Foundation
import RealmSwift

class ShoppingTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var productImage: String
    @Persisted var mallName: String
    @Persisted var productTitle: String
    @Persisted var price: String
    @Persisted var like: Bool
    
    convenience init(productImage: String, mallName: String, productTitle: String, price: String, like: Bool) {
        self.init()
        
        self.productImage = productImage
        self.mallName = mallName
        self.productTitle = productTitle
        self.price = price
        self.like = like
    }
}
