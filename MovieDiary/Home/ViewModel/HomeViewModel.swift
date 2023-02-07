//
//  HomeViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import Foundation

class HomeViewModel: BaseViewModel { // 사실상 HomeViewModel은 필요없음
    // View로부터 받은 요청
    struct Input {
    }
    
    // View에서 사용할 데이터
    struct Output {
        
    }
    
    // Input, Output 타입의 프로퍼티 선언 -> 초기화 해줘야한다.
    var input: Input
    var output: Output
    
    // 초기화
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBinding()
    }
    
    // View에서 input값이 바뀌었을 때 감지하는 메서드
    private func inputBinding() {
        
    }
}
