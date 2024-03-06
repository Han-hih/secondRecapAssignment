//
//  LikeViewController.swift
//  secondRecapAssignment
//
//  Created by 황인호 on 2023/09/07.
//

import UIKit
import RealmSwift

class LikeViewController: BaseViewController {

    lazy var searchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.placeholder = "검색어를 입력해주세요"
        view.setValue("취소", forKey: "cancelButtonText")
        view.showsCancelButton = true
        view.setImage(UIImage(named: "isSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        view.setImage(UIImage(named: "isCancel"), for: .clear, state: .normal)
        view.searchBarStyle = .minimal
        view.resignFirstResponder()
        
        return view
    }()
    
    //    private lazy var collectionView:  UICollectionView = {
//        let spacing: CGFloat = 10
//        let width = (UIScreen.main.bounds.size.width - (spacing * 3)) / 2
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: width, height: width * 1.5)
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        collectionView.register(ShopingListViewControllerCell.self, forCellWithReuseIdentifier: ShopingListViewControllerCell.identifier)
//        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.keyboardDismissMode = .onDrag
//        
//        
//        return collectionView
//    }()
    
    private lazy var tableView = {
        let view = UITableView()
        view.register(LikeTableViewCell.self, forCellReuseIdentifier: LikeTableViewCell.identifier)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.keyboardDismissMode = .onDrag
        view.rowHeight = 120
        return view
    }()

    
    var tasks: Results<ShoppingTable>!
    var taskList: [ShoppingTable] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        tasks = realm.objects(ShoppingTable.self).sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
        
    }
    
    override func configure() {
        super.configure()
        [searchBar, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            setNavigationBar()
        }
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        NSLayoutConstraint.activate([
            //searchBar
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40), //40이 최적화된 높이인 것 같다.
            // 컬렉션뷰
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "좋아요 목록"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
}

extension LikeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
    // 서치바 실시간으로 갱신되도록
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        taskList.removeAll()
        for item in tasks {
            if item.productTitle.contains(searchBar.text!) {
                taskList.append(item)
            }
        }
        tableView.reloadData()
        
        }
}

extension LikeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text?.isEmpty == true {
            return tasks.count
        } else {
            return taskList.count
        }
    }
    @objc func likeButtonTapped(_ sender: UIButton) {
        let shopping = tasks[sender.tag]
        
        let task = ShoppingTable(productId: shopping.productId, productImage: shopping.productImage, mallName: shopping.mallName , productTitle: shopping.productTitle, price: shopping.productTitle)
        
        if sender.imageView?.image == UIImage(systemName: "heart.fill") {
            ShopingListRepository.shared.removeItem(task)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikeTableViewCell.identifier, for: indexPath) as? LikeTableViewCell else { return UITableViewCell() }
        cell.heartButton.tag = indexPath.row
                //어차피 좋아요 버튼 눌려진 것들이 넘어오니까 기본을 heart.fill로 구현
                cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.heartButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
                var row = tasks[indexPath.row]
                if searchBar.text?.isEmpty == true {
                    row = tasks[indexPath.row]
                } else {
                    row = taskList[indexPath.row]
                }
        
                cell.likeConfigure(row: row)
        
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("눌림")
                let vc = WebkitViewController()
                vc.id = tasks[indexPath.row].productId
                vc.heartButtonFilled = true
                vc.title = tasks[indexPath.row].productTitle.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
                navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if searchBar.text?.isEmpty == true {
//            return tasks.count
//        } else {
//            return taskList.count
//        }
//    }
//    @objc func likeButtonTapped(_ sender: UIButton) {
//        let shopping = tasks[sender.tag]
//
//        let task = ShoppingTable(productId: shopping.productId, productImage: shopping.productImage, mallName: shopping.mallName , productTitle: shopping.productTitle, price: shopping.productTitle)
//        // 하트이미지를 프로토콜로 전달..?
//        if sender.imageView?.image == UIImage(systemName: "heart.fill") {
//            ShopingListRepository.shared.removeItem(task)
//            collectionView.reloadData()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopingListViewControllerCell.identifier, for: indexPath) as? ShopingListViewControllerCell else { return UICollectionViewCell() }
//        cell.heartButton.tag = indexPath.row
//        //어차피 좋아요 버튼 눌려진 것들이 넘어오니까 기본을 heart.fill로 구현
//        cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        cell.heartButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
//        var row = tasks[indexPath.row]
//        if searchBar.text?.isEmpty == true {
//            row = tasks[indexPath.row]
//        } else {
//            row = taskList[indexPath.row]
//        }
//
//        cell.likeConfigure(row: row)
//
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = WebkitViewController()
//        vc.id = tasks[indexPath.row].productId
//        vc.heartButtonFilled = true
//        vc.title = tasks[indexPath.row].productTitle.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
////        print(vc.id)
////        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(webLikeButtonTapped))
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
