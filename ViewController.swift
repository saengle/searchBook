//
//  ViewController.swift
//  SearchBook
//
//  Created by 쌩 on 5/2/24.
//

import UIKit

class ViewController: UITabBarController {
    

    let bookApi = BookApi()
    var bookDetails = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        bookApi.fetchBookDataUrlSession(query: "개발") { result in
//            switch result {
//            case .success(let bookDetails):
//                print(bookDetails)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
        
        
//        bookApi.fetchDataAlamofire(query: "창작", page: 1) {result in
//                        switch result {
//                        case .success(let bookDetails):
//                            print(bookDetails)
//                        case .failure(let error):
//                            print(error.localizedDescription)
//        }
//        }
        
        addVC()
    }
    private func addVC() {
        let searchVC = SearchView()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "1.circle"), selectedImage: UIImage(systemName: "1.circle.fill"))
        
        
        let wishVC = WishListView()
        wishVC.tabBarItem = UITabBarItem(title: "WishList", image: UIImage(systemName: "1.circle"), selectedImage: UIImage(systemName: "1.circle.fill"))
        
        self.viewControllers = [searchVC, wishVC]
    }
}

#Preview {
  ViewController()
}
