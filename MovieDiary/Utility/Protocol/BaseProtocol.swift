//
//  BaseProtocol.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/03.
//

import Foundation

protocol BaseViewInputOutput {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
