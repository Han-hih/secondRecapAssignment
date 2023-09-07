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
    
    
    
    override func configure() {
        [shoppingImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .cyan
        
        NSLayoutConstraint.activate([
            shoppingImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shoppingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shoppingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shoppingImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7)
        
        ])
    }
    
    
    
    
    
    
}
