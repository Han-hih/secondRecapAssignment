//
//  LikeViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/07.
//

import UIKit

class LikeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
    }
    

    func setNavigationBar() {
        self.navigationItem.title = "좋아요 목록"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    

}
