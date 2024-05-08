//
//  WishListView.swift
//  SearchBook
//
//  Created by 쌩 on 5/7/24.
//

import UIKit

import SnapKit

class WishListView: UIViewController {
    
    let topStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis = .horizontal
        stView.backgroundColor = .white
        return stView
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("구매", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let wishListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cyan
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.wishListTableView.delegate = self
        self.wishListTableView.dataSource = self
        setUI()
    }
    
}

extension WishListView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = "안녕"
        cell.backgroundColor = .blue
        return cell
    }
    
    private func setUI() {
        addSubView()
        setConstraints()
    }
    
    private func addSubView() {
        self.view.addSubview(topStackView)
        [deleteButton, nameLabel, addButton].forEach{
            topStackView.addSubview($0)
        }
        self.view.addSubview(wishListTableView)
    }
    
    private func setConstraints() {
        topStackViewConstraints()
        deleteButtonConstraints()
        nameLabelConstraints()
        addButtonConstraints()
        wishListTVConstraints()
    }
    
    private func topStackViewConstraints() {
        topStackView.snp.makeConstraints{ make in
            make.directionalHorizontalEdges.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
    }
    
    private func deleteButtonConstraints() {
        deleteButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    private func nameLabelConstraints() {
        nameLabel.snp.makeConstraints{ make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    private func addButtonConstraints() {
        addButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
    }
    
    private func wishListTVConstraints() {
        wishListTableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topStackView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


#Preview {
    ViewController()
}
