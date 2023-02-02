//
//  HomeCellViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/02.
//

import Foundation
import RxSwift

class cellViewModel: BaseViewModel {
    // View로부터 받은 요청
    struct Input {
        let initTrigger: Observable<String> = Observable<String>.just("")
    }
    
    
    // View에서 사용할 데이터
    struct Output {
        let data: Dynamic<ResponseData?> = Dynamic(nil)
        
    }
    
    var input: Input
    var output: Output
    var posterList: [String] = []
    let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBinding()
    }
    
    // View에서 input값이 바뀌었을 때 감지하는 메서드
    private func inputBinding() {
        self.input.initTrigger
            .subscribe(onNext: { data in
                
            }, onError: { error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            .disposed(by: disposeBag)
        
//        self.input.initTrigger.bind { [weak self] url in
//            guard let url = url else { return }
//            HomeAPIManager.shared.getHomeAPI(url: url) { completion in
//                switch completion {
//                case let .success(responseData):
//                    // output의 값에 responseData를 넣어줌으로써 output 값 변경 -> View에서 감지
//                    self?.output.data.value = responseData
//                    for ele in responseData.results {
//                        self?.posterList.append(ele.posterPath)
//                    }
//                case let .failure(error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
    
    
}
