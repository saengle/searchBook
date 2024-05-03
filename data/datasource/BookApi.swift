//
//  BookApi.swift
//  SearchBook
//
//  Created by 쌩 on 5/3/24.
//

import Foundation
import Alamofire



class BookApi {
    
    private var apiID: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "clientID") as? String else {
                fatalError("Couldn't find key 'CLIENT_ID' in 'Info.plist'.")
            }
            return value
        }
    }
    
    private var apiSecret: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "clientSecret") as? String else {
                fatalError("Couldn't find key 'CLIENT_SECRET' in 'Info.plist'.")
            }
            return value
        }
    }
    
    
    let url = "https://openapi.naver.com/v1/search/book.json"
    
    
    func fetchBookDataUrlSession(query: String, completion: @escaping ((Result<[Item], Error> ) -> Void)) {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "query", value: String(query.utf8)), URLQueryItem(name: "display", value: "10"), URLQueryItem(name: "start", value: "1"), URLQueryItem(name: "sort", value: "sim")]
        
        guard let url = URL(string: "\(url)") else {
            completion(.failure(NSError(domain: "Url변환에 실패했습니다.", code: 444)))
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        //        request.allHTTPHeaderFields = [
        //            "X-Naver-Client-Id": "\(apiID)",
        //            "X-Naver-Client-Secret": "\(apiSecret)"]
        request.addValue(apiID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(apiSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request) { data, task, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data가 없어요", code: 402)))
                return
            }
            do {
                let books = try JSONDecoder().decode(Books.self, from: data)
                completion(.success(books.items))
            } catch {
                completion(.failure(error))
                print("completion failure Error")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
}

