//
//  WebkitViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/10.
//

import UIKit
import WebKit
import RealmSwift

class WebkitViewController: BaseViewController, WKUIDelegate {
    
    var webView = WKWebView()
    var heartButtonFilled = true
    var id = ""
    var tasks: Results<ShoppingTable>!
    var productTitle = ""
    var image = ""
    var mallName = ""
    var price = ""
    let realm = try! Realm()
    
    override func configure() {
        super.configure()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
      
        openURL(id)
        navigationSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let task = realm.objects(ShoppingTable.self)
        let data = task.where {
            $0.productId == id
        }
        if data.isEmpty {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
    }
    
    @objc func heartButtonTapped() {
        if navigationItem.rightBarButtonItem?.image == UIImage(systemName: "heart.fill") {
            let task = realm.objects(ShoppingTable.self)
            let data = task.where {
                $0.productId == id
            }
            let updateData = data[0]
            if data.isEmpty == false {
                ShopingListRepository.shared.removeItem(updateData)
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            }
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            ShopingListRepository.shared.createItem(ShoppingTable(productId: id, productImage: image, mallName: mallName, productTitle: productTitle, price: price))
        }
    }
   
    
    override func setConstraints() {
        super.setConstraints()
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func openURL(_ productID: String) {
        let myURL = URL(string: "https://msearch.shopping.naver.com/product/\(productID)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    func navigationSetting() {
        if realm.objects(ShoppingTable.self).contains(where: { ShoppingTable in
            ShoppingTable.productId == id
        }) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(heartButtonTapped))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        }
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]


    }
}


