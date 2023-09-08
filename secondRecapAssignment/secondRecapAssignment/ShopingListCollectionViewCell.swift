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
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let heartButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let mallNameLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.sizeToFit()
        label.font = .systemFont(ofSize: 10)
        label.text = "[네이버 쇼핑몰]"
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.text = "sddfaldfsdfasfdasfsdfaff"
        return label
    }()
    //숫자가 커질 때 글자크기가 작아지게
    let priceLabel = {
        let label = UILabel()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4 // 줄어들 수 있는 비율
        label.text = numberFormatter.string(from: 12344000) // 대략 100억 까지만 으로 가정

        return label
    }()
    
    override func configure() {
        [shoppingImageView, buttonView, heartButton, mallNameLabel, titleLabel, priceLabel].forEach {
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
            buttonView.widthAnchor.constraint(equalTo: buttonView.heightAnchor),
            //하트버튼
            heartButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            heartButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            //쇼핑몰네임
            mallNameLabel.topAnchor.constraint(equalTo: shoppingImageView.bottomAnchor, constant: 5),
            mallNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mallNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //제품이름 레이블
            titleLabel.topAnchor.constraint(equalTo: mallNameLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: mallNameLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: mallNameLabel.trailingAnchor),
            //가격레이블
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: mallNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: mallNameLabel.trailingAnchor)
        
        ])
    }
    
    
    
    
    
    
}
