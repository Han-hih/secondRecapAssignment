//
//  CustomButton.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import UIKit

class CustomButton: UIButton {
    
    var toggleButtonChecked = false
    var buttonValue = ""
    
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
        backgroundColor = .white
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        toggleButtonChecked.toggle()
        if toggleButtonChecked == false {
            setTitleColor(.black, for: .normal)
            backgroundColor = .white
        } else {
            backgroundColor = .black
            setTitleColor(.white, for: .normal)
            buttonValue = (sender.titleLabel?.text)!
            print(buttonValue)
        }
    }
}
