//
//  ViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/07.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.placeholder = "검색어를 입력해주세요"
        view.showsCancelButton = true
        view.setImage(UIImage(named: "isSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        view.setImage(UIImage(named: "isCancel"), for: .clear, state: .normal)
        view.setValue("취소", forKey: "cancelButtonText")
        view.searchBarStyle = .minimal
        return view
    }()
    
    let buttonView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var accuracyButton = {
        let button = CustomButton()
        button.setTitle(" 정확도 ", for: .normal)
        button.addTarget(self, action: #selector(accuracySort), for: .touchUpInside)
        return button
    }()
    
    lazy var dateButton = {
        let button = CustomButton()
        button.setTitle(" 날짜순 ", for: .normal)
        button.addTarget(self, action: #selector(dateSort), for: .touchUpInside)
        return button
    }()
    
    lazy var highPriceButton = {
        let button = CustomButton()
        button.setTitle(" 가격높은순 ", for: .normal)
        button.addTarget(self, action: #selector(highPriceSort), for: .touchUpInside)
        return button
    }()
    
    lazy var lowPriceButton = {
        let button = CustomButton()
        button.setTitle(" 가격낮은순 ", for: .normal)
        button.addTarget(self, action: #selector(lowPriceSort), for: .touchUpInside)
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
        collectionView.prefetchDataSource = self
        
        return collectionView
    }()
    
    var list: [items] = []
    var start = 1
    var sort = "sim"
    var buttonArray: [UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [accuracyButton, dateButton, highPriceButton, lowPriceButton].forEach {
            buttonArray.append($0)
        }
        [searchBar, buttonView, accuracyButton, dateButton, highPriceButton, lowPriceButton, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        setNavigationBar()
        
        setConstraints()
    }
    
    //휴먼에러.......................
    // 어차피 마지막 누른 버튼값으로 sort가 들어가니까
    // 정렬을 두개(ex 정확도 + 오름차순)이상으로 하고 싶다면 배열사용..? 오름차순 + 내림차순 일 때 문제가 생겨서 다른 방식으로
    //검색을 한 상태에서도 다시 리로드 되도록
        @objc func accuracySort() {
            if accuracyButton.backgroundColor == .black {
                sort = "sim"
                // 버튼이 고정되어 있으니까 remove를 index 번호로 설정
                buttonArray.remove(at: 0)
                buttonArray.forEach {
                    $0.setTitleColor(.black, for: .normal)
                    $0.backgroundColor = .white
                }
                //다시 추가해준다.
                buttonArray.insert(accuracyButton, at: 0)
            }
        }
    @objc func dateSort() {
        if dateButton.backgroundColor == .black {
            sort = "date"
            buttonArray.remove(at: 1)
            buttonArray.forEach {
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = .white
            }
            buttonArray.insert(dateButton, at: 1)
        } else {
            sort = "sim"
        }
    }
    @objc func highPriceSort() {
        if highPriceButton.backgroundColor == .black {
            sort = "dsc"
            buttonArray.remove(at: 2)
            buttonArray.forEach {
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = .white
            }
            buttonArray.insert(highPriceButton, at: 2)
        } else {
            sort = "sim"
        }
    }
    @objc func lowPriceSort() {
        if lowPriceButton.backgroundColor == .black {
            sort = "asc"
            buttonArray.remove(at: 3)
            buttonArray.forEach {
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = .white
            }
            buttonArray.insert(lowPriceButton, at: 3)
        } else {
            sort = "sim"
        }
    }
    
    @objc func heartButtonTapped() {
        
    }
    func callShopingRequest(_ query: String, _ sort: String, _ page: Int) {
        ShopingAPIManager.shared.listRequest(query: query, sort: sort, page: page) { value in
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
        start = 1
        list.removeAll()
        guard let query = searchBar.text else { return }
        callShopingRequest(query, sort, start)
        print(sort)
    }
}
// 데이터가 계속 있으면 상관없지만 51개, 40몇개 등등 있을 때 어떻게 페이지네이션을 처리해줄지...
// 애초에 start가 100이 최대로 고정되어 있어서 따로 고려안해줘도 된다..?
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && start < 1000  {
                // display가 30개로 기본 세팅 되어있어서 30개씩 플러스 해줘야 다음 페이지로 넘어간다.
                //뭔가 말로 설명이 잘 안된다,
                start += 30
                print(list.count)
                guard let query = searchBar.text else { return }
                callShopingRequest(query, "sim", start)
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("___________________")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopingListViewControllerCell.identifier, for: indexPath) as? ShopingListViewControllerCell else { return UICollectionViewCell() }
        let row = list[indexPath.row]
        cell.configure(row: row)
        
        return cell
    }
    
    
}
