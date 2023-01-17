//
//  APIService.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - ResponseData
struct ResponseData: Codable {
    let page: Int
    let results: [Result]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Result: Codable {
    let posterPath: String
    let adult: Bool
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let title, backdropPath: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

class APIService {
    func getHomeAPI(url: String, completionHandler: @escaping (JSON) -> Void) {
        let headers : HTTPHeaders = ["Content-Type" : "application/json;charset=utf-8"]
        AF.request(url, method: .get, headers: headers).validate().validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                
                completionHandler(json)
                
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                print(statusCode)
            }
        }
    }
}
