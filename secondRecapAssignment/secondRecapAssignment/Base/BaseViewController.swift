//
//  BaseViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/10.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    func configure() {
        view.backgroundColor = LightColor.background
    }
    
    func setConstraints() {}
}

