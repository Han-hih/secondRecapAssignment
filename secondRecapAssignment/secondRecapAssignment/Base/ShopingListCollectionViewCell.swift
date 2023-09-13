//
//  ShopingListCollectionViewCell.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/08.
//

import UIKit
import RealmSwift

class ShopingListViewControllerCell: BaseCollectionViewCell {
    static let shared = ShopingListViewControllerCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var shoppingImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = LightColor.background
        return view
        
    }()
    
    lazy var heartButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.tintColor = .black
        //        button.addTarget(self, action: #selector(heartButtonToggle), for: .touchUpInside)
        return button
    }()
    
    lazy var mallNameLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.sizeToFit()
        label.font = .systemFont(ofSize: 10)
        label.text = "[네이버 쇼핑몰]"
        return label
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    //숫자가 커질 때 글자크기가 작아지게
    lazy var priceLabel = {
        let label = UILabel()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4 // 줄어들 수 있는 비율
        //        label.text = numberFormatter.string(from: priceLabel.text) // 대략 100억 까지만 으로 가정
        
        return label
    }()
    var toggleButtonChecked = false
    var tasks: Results<ShoppingTable>!
    
    func configure(row: items) {
        mallNameLabel.text = "\(row.mallName ?? "네이버쇼핑")"
        titleLabel.text = "\(row.title)".replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .decimal
        priceLabel.text = numberformatter.string(from: (Int(row.lprice) ?? 0) as NSNumber)
        guard let url = URL(string: row.image) else { return }
        shoppingImageView.load(url: url)
        
    }
    
    func likeConfigure(row: ShoppingTable) {
        mallNameLabel.text = "\(row.mallName)"
        titleLabel.text = "\(row.productTitle)".replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .decimal
        priceLabel.text = numberformatter.string(from: (Int(row.price) ?? 0) as NSNumber)
        guard let url = URL(string: row.productImage) else { return }
        shoppingImageView.load(url: url)
    }
    // MARK: - 수정필요
    
    //    @objc func heartButtonToggle(_ sender: UIButton) {
    //        toggleButtonChecked.toggle()
    //
    //        if toggleButtonChecked == false {
    //            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    //        } else {
    //            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    //        }
    //    }
    
    override func configure() {
        [shoppingImageView, heartButton, mallNameLabel, titleLabel, priceLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        //        contentView.layer.cornerRadius = 30 // 있을 필요가 없다...?
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            //쇼핑 이미지
            shoppingImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shoppingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shoppingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shoppingImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            //하트버튼
            heartButton.trailingAnchor.constraint(equalTo: shoppingImageView.trailingAnchor, constant: -10),
            heartButton.bottomAnchor.constraint(equalTo: shoppingImageView.bottomAnchor, constant: -10),
            heartButton.heightAnchor.constraint(equalTo: shoppingImageView.heightAnchor, multiplier: 0.2),
            heartButton.widthAnchor.constraint(equalTo: heartButton.heightAnchor),
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
    override func prepareForReuse() {
        super.prepareForReuse()
        shoppingImageView.image = UIImage()
    }
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
