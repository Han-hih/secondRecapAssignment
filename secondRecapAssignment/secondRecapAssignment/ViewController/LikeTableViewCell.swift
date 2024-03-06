//
//  LikeTableViewCell.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 3/5/24.
//

import UIKit
import SnapKit

class LikeTableViewCell: UITableViewCell {
    
    let productImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var heartButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
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
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var priceLabel = {
        let label = UILabel()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4 // 줄어들 수 있는 비율
        //        label.text = numberFormatter.string(from: priceLabel.text) // 대략 100억 까지만 으로 가정
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setUI()
    }

    
    func setUI() {
        [productImageView, heartButton, mallNameLabel, titleLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
        productImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(75)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.top.equalTo(productImageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mallNameLabel)
            make.top.equalTo(mallNameLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(mallNameLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func configure(row: items) {
        mallNameLabel.text = "\(row.mallName ?? "[네이버쇼핑]")"
        titleLabel.text = "\(row.title)".replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .decimal
        priceLabel.text = numberformatter.string(from: (Int(row.lprice) ?? 0) as NSNumber)! + "원"
        guard let url = URL(string: row.image) else { return }
        productImageView.load(url: url)
        
    }
    
    func likeConfigure(row: ShoppingTable) {
        mallNameLabel.text = "\(row.mallName)"
        titleLabel.text = "\(row.productTitle)".replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .decimal
        priceLabel.text = numberformatter.string(from: (Int(row.price) ?? 0) as NSNumber)! + "원"
        guard let url = URL(string: row.productImage) else { return }
        productImageView.load(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
