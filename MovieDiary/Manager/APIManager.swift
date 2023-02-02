//
//  APIService.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import Foundation
import Alamofire

//MARK: 서버에서 받아온 데이터를 Struct 형태로 만들어서 전달. -> Service가 받게됨

// Rxswift 사용해서 리팩토링 해보기
class HomeAPIManager {
    static let shared = HomeAPIManager()
    // Result 타입 적용
    func getHomeAPI(url: String, completion: @escaping (Result<ResponseData, Error>) -> Void) {
        let headers : HTTPHeaders = ["Content-Type" : "application/json;charset=utf-8"]
        AF.request(url, method: .get, headers: headers).validate().validate(statusCode: 200...500).responseDecodable(of: ResponseData.self ) { response in
            switch response.result {
            case let .success(value):
                guard let statusCode = response.response?.statusCode else { return }
                print("Success\(statusCode)")
                completion(.success(value))
                
            case let .failure(error):
                guard let statusCode = response.response?.statusCode else { return }
                completion(.failure(error))
                print("Failure\(statusCode)")
            }
        }
    }
    
    
    // RX 리팩토링
    
}
