//
//  Shoping.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import Foundation

struct Shoping: Codable {
    let total: Int
    let start: Int
    let display: Int
    let items: [items]
}

struct items: Codable {
    let title: String
    let link: String
    let image: String
    let mallName: String?
    let productId: String
}
