//
//  ResponseDataModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/02.
//

import Foundation

// MARK: 서버에서 받아온 데이터 타입
// MARK: - ResponseData
struct ResponseData: Codable {
    let page: Int
    let results: [ResultModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
