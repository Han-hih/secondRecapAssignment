//
//  ShoppingTable.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/09.
//

import Foundation
import RealmSwift

class ShoppingTable: Object {
    
    @Persisted(primaryKey: true) var productId: String
    @Persisted var productImage: String
    @Persisted var mallName: String
    @Persisted var productTitle: String
    @Persisted var price: String
    @Persisted var like: Bool
    @Persisted var date: Date
    
    convenience init(productId: String, productImage: String, mallName: String, productTitle: String, price: String) {
        self.init()
        
        self.productId = productId
        self.productImage = productImage
        self.mallName = mallName
        self.productTitle = productTitle
        self.price = price
        self.like = false
        self.date = Date()
    }
}
