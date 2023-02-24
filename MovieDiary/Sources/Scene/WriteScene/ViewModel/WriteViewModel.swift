//
//  WriteViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/24.
//

import Foundation


class WriteViewModel: BaseViewModel {
    struct Input {
        
    }
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
