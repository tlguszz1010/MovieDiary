//
//  Extension + APIIndex.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/01.
//

import Foundation

@frozen enum APIIndex: Int, CaseIterable {
    case popularIdx
    case toprateIdx
    case upcomingIdx
    
    var sectionTitle: String {
        switch self {
        case .popularIdx:
            return "인기있는 영화"
        case .toprateIdx:
            return "평점 높은 영화"
        case .upcomingIdx:
            return "개봉 예정인 영화"
        }
    }
    
    var sectionURL: String {
        switch self {
        case .popularIdx:
            return BaseURL.popularURL + APIKey.TMDB + EndPoint.language
        case .toprateIdx:
            return BaseURL.topRatedURL + APIKey.TMDB + EndPoint.language
        case .upcomingIdx:
            return BaseURL.upcomingURL + APIKey.TMDB + EndPoint.language
        }
    }
    
    static var numberOfRows: Int {
        return Self.allCases.count
    }
}
