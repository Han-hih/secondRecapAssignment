//
//  WebkitViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/10.
//

import UIKit
import WebKit

class WebkitViewController: BaseViewController, WKUIDelegate {
    
    var webView = WKWebView()
    var id = ""
    
    
    override func configure() {
        super.configure()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        openURL(id)
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
}


