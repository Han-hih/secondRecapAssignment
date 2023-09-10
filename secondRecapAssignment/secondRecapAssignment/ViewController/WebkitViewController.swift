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
    override func configure() {
        super.configure()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        let realm = try! Realm()
        tasks = realm.objects(ShoppingTable.self)
        openURL(id)
        navigationSetting()
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        if navigationItem.rightBarButtonItem?.image == UIImage(systemName: "heart.fill") {
            let shopping = tasks[sender.tag]
            let task = ShoppingTable(productId: shopping.productId, productImage: shopping.productImage, mallName: shopping.mallName , productTitle: shopping.productTitle, price: shopping.productTitle)
            
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            ShopingListRepository.shared.removeItem(task)
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(heartButtonTapped))
//        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
    }
}


