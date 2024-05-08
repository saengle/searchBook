//
//  SearchView.swift
//  SearchBook
//
//  Created by 쌩 on 5/7/24.
//

import UIKit

class SearchView: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .black
        
        
        return searchBar
    }()
    
    
    
    let recentListLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 본 책"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var recentCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.backgroundColor = .white
        
        return view
    }()
    
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = .init(width: 100, height: 100)
//        let spacing: CGFloat = 8
//        let countForLine: CGFloat = 1
//        let deviceWidth = UIScreen.main.bounds.width
//        let cellWidth = (deviceWidth - spacing *)
        return layout
    }()
    
    let searchedTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        setUI()
        configureCollectionView()
        configureTableView()
    }
    
    private func configureCollectionView() {
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        recentCollectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: "RecentCollectionViewCell")
    }
    
    private func configureTableView() {
        searchedTableView.delegate = self
        searchedTableView.dataSource = self
        
    }
}
extension SearchView {
    
    private func setUI() {
        addSubView()
        setConstraints()
    }
    
    private func addSubView() {
        [searchBar, recentListLabel, recentCollectionView, searchedTableView].forEach{self.view.addSubview($0)}
//        self.view.addSubview(collectionView)
        
    }
    
    private func setConstraints() {
        searchBarConstraints()
        recentListLabelConstraints()
        collectionViewConstraints()
        searchedTableViewConstraints()
    }
    
    private func searchBarConstraints() {
        searchBar.snp.makeConstraints{ make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    private func recentListLabelConstraints() {
        recentListLabel.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(15)
        }
        
    }
    
    private func collectionViewConstraints() {
        recentCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(recentListLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
    }
    
    private func searchedTableViewConstraints() {
        searchedTableView.snp.makeConstraints{ make in
            make.top.equalTo(recentCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
            
            
        }
        
    }
    
}

extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCollectionViewCell", for: indexPath) as? RecentCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = .cyan
        cell.bgImageView.image = UIImage(systemName: "plus")
        cell.nameLabel.text = "우와"
        return cell
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "테스트용 라벨"
        return cell
    }
    
   
}

#Preview {
  ViewController()
}
