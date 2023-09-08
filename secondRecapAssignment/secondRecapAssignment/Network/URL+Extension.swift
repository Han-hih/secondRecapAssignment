//
//  URL+Extension.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import Foundation

extension URL {
    static let baseURL = "https://openapi.naver.com/v1/search/shop.json?query="
    
    static func makeURL(_ query: String, _ sort: String) -> String {
        guard let data = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }

        return baseURL + "\(data)" + "&display=30&sort=" + sort
    }
}
