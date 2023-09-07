//
//  CustomButton.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setTitleColor(.black, for: .normal)
        tintColor = .white
    }
}
