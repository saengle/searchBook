//
//  ViewController.swift
//  SearchBook
//
//  Created by 쌩 on 5/2/24.
//

import UIKit

class ViewController: UIViewController {
    let bookApi = BookApi()
    var bookDetails = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bookApi.fetchBookDataUrlSession(query: "개발") { result in
            switch result {
            case .success(let bookDetails):
                print(bookDetails)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}




