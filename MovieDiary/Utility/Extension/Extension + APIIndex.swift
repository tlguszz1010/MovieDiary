//
//  Extension + APIIndex.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/01.
//

import Foundation

@frozen enum APIIndex : Int, CaseIterable {
    case popularIdx
    case toprateIdx
    case upcomingIdx
    
    var SectionTitle : String {
        switch self {
        case .popularIdx:
            return "인기있는 영화"
        case .toprateIdx:
            return "평점 높은 영화"
        case .upcomingIdx:
            return "개봉 예정인 영화"
            
        }
    }
    
    static var numberOfRows: Int {
        return Self.allCases.count
    }
}
