//
//  ViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/07.
//

import UIKit

class ViewController: UIViewController {
    
    let searchBar = {
    let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        view.showsCancelButton = true
        view.setImage(UIImage(named: "isSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        view.setImage(UIImage(named: "isCancel"), for: .clear, state: .normal)
        return view
    }()
    
    let buttonView = {
        let view = UIView()
        
        return view
    }()
    
    let accuracyButton = {
        let button = CustomButton()
        button.setTitle(" 정확도 ", for: .normal)
        
        return button
    }()
    
    let dateButton = {
        let button = CustomButton()
        button.setTitle(" 날짜순 ", for: .normal)
        
        return button
    }()
    
    let highPriceButton = {
        let button = CustomButton()
        button.setTitle(" 가격높은순 ", for: .normal)
        
        return button
    }()
    
    let lowPriceButton = {
        let button = CustomButton()
        button.setTitle(" 가격낮은순 ", for: .normal)
        
        return button
    }()
    
    private lazy var collectionView:  UICollectionView = {
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.size.width - (spacing * 3)) / 2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ShopingListViewControllerCell.self, forCellWithReuseIdentifier: ShopingListViewControllerCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    var list: [items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callShopingRequest("캠핑카", "sim")
        view.backgroundColor = .white
        searchBar.delegate = self
        
        [searchBar, buttonView, accuracyButton, dateButton, highPriceButton, lowPriceButton, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setNavigationBar()
        
        setConstraints()
    }
    
    func callShopingRequest(_ query: String, _ sort: String) {
        ShopingAPIManager.shared.listRequest(query: query, sort: sort) { value in
            for item in value?.items ?? [] {
                let title = item.title
                let mallName = item.mallName
                let image = item.image
                let id = item.productId
                let price = item.lprice
                self.list.append(items(title: title, image: image, mallName: mallName ?? "네이버쇼핑", lprice: price ,productId: id))
            }
            self.collectionView.reloadData()
//            guard let data = value?.items else {
//                print("Error")
//                return
//            }
            
//            print(self.list)
        }
        
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "쇼핑 검색"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            //searchBar
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40), //40이 최적화된 높이인 것 같다.
            //버튼이 들어가기 위한 뷰
            buttonView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            buttonView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            buttonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            //정확도 버튼
            accuracyButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            accuracyButton.heightAnchor.constraint(equalTo: buttonView.heightAnchor, multiplier: 0.8),
            accuracyButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 8),
            //날짜순 버튼
            dateButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            dateButton.heightAnchor.constraint(equalTo: accuracyButton.heightAnchor),
            dateButton.leadingAnchor.constraint(equalTo: accuracyButton.trailingAnchor, constant: 8),
            //가격높은순 버튼
            highPriceButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            highPriceButton.heightAnchor.constraint(equalTo: accuracyButton.heightAnchor),
            highPriceButton.leadingAnchor.constraint(equalTo: dateButton.trailingAnchor, constant: 8),
            //가격낮은순 버튼
            lowPriceButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            lowPriceButton.heightAnchor.constraint(equalTo: accuracyButton.heightAnchor),
            lowPriceButton.leadingAnchor.constraint(equalTo: highPriceButton.trailingAnchor, constant: 8),
            // 컬렉션뷰
            collectionView.topAnchor.constraint(equalTo: buttonView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}
extension ViewController: UISearchBarDelegate {
    
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(list.count, "______________________________--")
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopingListViewControllerCell.identifier, for: indexPath) as? ShopingListViewControllerCell else { return UICollectionViewCell() }
        cell.shoppingImageView.backgroundColor = .blue
        let row = list[indexPath.row]
        cell.configure(row: row)
        
        return cell
    }
    
    
}
