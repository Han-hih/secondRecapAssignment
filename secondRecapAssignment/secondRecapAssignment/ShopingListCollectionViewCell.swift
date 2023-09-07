//
//  ShopingListCollectionViewCell.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import UIKit

class ShopingListViewControllerCell: BaseCollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let shoppingImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemPink
        return view
        
    }()
    
    let buttonView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override func configure() {
        [shoppingImageView, buttonView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .cyan
        
        NSLayoutConstraint.activate([
            //쇼핑 이미지
            shoppingImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shoppingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shoppingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shoppingImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            //하트버튼이 들어갈 뷰
            buttonView.trailingAnchor.constraint(equalTo: shoppingImageView.trailingAnchor, constant: -10),
            buttonView.bottomAnchor.constraint(equalTo: shoppingImageView.bottomAnchor, constant: -10),
            buttonView.heightAnchor.constraint(equalTo: shoppingImageView.heightAnchor, multiplier: 0.2),
            buttonView.widthAnchor.constraint(equalTo: buttonView.heightAnchor)
        
        ])
    }
    
    
    
    
    
    
}
