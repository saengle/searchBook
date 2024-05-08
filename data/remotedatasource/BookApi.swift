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
    
    
    let baseUrl = "https://openapi.naver.com/v1/search/book.json"
    
    
    func fetchBookDataUrlSession(query: String, completion: @escaping ((Result<[Book], Error> ) -> Void)) {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "query", value: String(query.utf8)), URLQueryItem(name: "display", value: "10"), URLQueryItem(name: "start", value: "1"), URLQueryItem(name: "sort", value: "sim")]
        
        guard let url = URL(string: "\(baseUrl)") else {
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
    
    func fetchDataAlamofire(query: String, page: Int, completion: @escaping((Result<[Book], Error>) -> Void)) {
        // Mark:  query를 파라미터 타입의 딕셔너리에 담음
        let parameters = [
            "query" : "\(query.utf8)",
            "display" : "10",
            "start": "\(page)",
            "sort": "sim"
        ]
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "\(apiID)",
            "X-Naver-Client-Secret": "\(apiSecret)"]
        
        // Mark:파라미터에 쿼리를 담고(파라미터 형식의 딕셔너리에 담은)
        // encoding을 JSONEncoding.default로 함
        /* 
         * 딕셔너리 형태는 URL뒤에 붙지도 않고, json 형식도 아니다. 따라서 따로 encoding을 해줘야한다.
         * 쿼리 파라미터는 URL 뒤에 붙는다. 따라서 URLEncoding.default이다.
         * Body에 담는 데이터의 타입은 JSON이다. 따라서 Body에 데이터를 담으려면 JSONEncoding.default로 해줘야한다.
         */
        
        AF.request(self.baseUrl, method: .get, parameters: parameters ,encoding: URLEncoding.default, headers: headers).responseDecodable(of: Books.self) { response in
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories.items))
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
}

