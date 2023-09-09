//
//  ShopingAPIManager.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import UIKit

class ShopingAPIManager {

    static let shared = ShopingAPIManager()
    private init() { }
    
    
    
    func listRequest(query: String, sort: String, page: Int, completionHandler: @escaping (Shoping?) -> Void) {
    guard let url = URL(string: URL.makeURL(query, sort, page)) else { return }
    var request = URLRequest(url: url)
    request.addValue(APIKey.naverID, forHTTPHeaderField: "x-naver-client-id")
    request.addValue(APIKey.naverClientSecret, forHTTPHeaderField: "x-naver-client-secret")
        print(url)
    let statusCode = 200...500
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                completionHandler(nil)
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, statusCode.contains(response.statusCode) else {
                completionHandler(nil)
                print(error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Shoping.self, from: data)
                completionHandler(result)
//                print(result)
                return
            }
            catch {
                completionHandler(nil)
                print(error)
            }
        }        
    }.resume()
}

}
