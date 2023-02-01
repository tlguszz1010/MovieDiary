//
//  HomeViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}

class HomeViewModel: BaseViewModel {
    
    // Input, Output 타입의 프로퍼티 선언 -> 초기화 해줘야한다.
    var input : Input
    var output: Output
    
    
    // 초기화
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBinding()
    }
    
    // View로부터 받은 요청
    struct Input {
        let viewDidLoadTrigger: Dynamic<Void?> = Dynamic(nil)
    }
    
    // View에서 사용할 데이터
    struct Output {
        // 기본 HomeView에서 사용할 데이터가 뭐지? url인가?
        let url : String = ""
    }
    
    
    // View에서 input값이 바뀌었을 때 감지하는 메서드
    private func inputBinding() {
        self.input.viewDidLoadTrigger.bind {  _ in
            
            print("HomeView 값 바뀜")
        }
    }
}


class cellViewModel: BaseViewModel {
    var input: Input
    var output: Output
    var posterList: [String] = []
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBinding()
    }
    
    
    // View로부터 받은 요청
    struct Input {
        let initTrigger: Dynamic<Void?> = Dynamic(nil)
    }
    
    
    // View에서 사용할 데이터
    struct Output {
        let data: Dynamic<ResponseData?> = Dynamic(nil)
    }
    
    // View에서 input값이 바뀌었을 때 감지하는 메서드
    private func inputBinding() {
        // url을 섹션에 따라 나눠서 각각 다른 url을 넣어줘야 하는데 이 부분을 어떻게 처리해줘야 할지 잘 모르겠음
        // ex. section 0 - popular URL, section 1 - totalRatedURL ...
        self.input.initTrigger.bind { [weak self] _ in
            Repository.shared.getHomeAPI(url: BaseURL.popularURL + APIKey.TMDB) { completion in
                switch completion {
                case let .success(responseData):
                    // output의 값에 responseData를 넣어줌으로써 output 값 변경 -> View에서 감지
                    self?.output.data.value = responseData
                    for ele in responseData.results {
                        self?.posterList.append(ele.posterPath)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
