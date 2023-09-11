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
    var id = ""
    var heartButtonFilled = true
    var tasks: Results<ShoppingTable>!
    var table = [items]()
    let realm = try! Realm()
    override func configure() {
        super.configure()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        
        tasks = realm.objects(ShoppingTable.self)
        openURL(id)
        navigationSetting()
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        let shopping = tasks[sender.tag]
        let addShopping = table[sender.tag]
        let task = ShoppingTable(productId: shopping.productId, productImage: shopping.productImage, mallName: shopping.mallName , productTitle: shopping.productTitle, price: shopping.productTitle)
        let addTask = ShoppingTable(productId: addShopping.productId, productImage: addShopping.image, mallName: addShopping.mallName ?? "[네이버쇼핑]", productTitle: addShopping.title, price: addShopping.lprice)
        if navigationItem.rightBarButtonItem?.image == UIImage(systemName: "heart.fill") {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            ShopingListRepository.shared.removeItem(task)
            //여기 까지는 잘됨
        } else {
            // 오류
            print(addTask)
            ShopingListRepository.shared.createItem(addTask)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")

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


