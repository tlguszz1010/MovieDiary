//
//  DecodeError.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/02.
//

import Foundation

enum DecodeError: Error, LocalizedError {
    case decodeErr
    
    var errorDescription: String? {
        switch self {
        case .decodeErr:
            return "디코딩 안됨"
        }
    }
}
