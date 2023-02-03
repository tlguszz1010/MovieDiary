//
//  HomeCellViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/02.
//

import Foundation
import RxSwift
import RxCocoa

class cellViewModel: BaseViewModel {
    // View로부터 받은 요청
    struct Input {
        let initTrigger: PublishSubject<String> = PublishSubject()
    }
    
    
    // View에서 사용할 데이터
    struct Output {
        let posterList: BehaviorRelay<[String]?> = BehaviorRelay(value: nil)
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
            .subscribe(onNext: { [weak self] apiURL in
                HomeAPIManager.shared.getHomeAPIWithRx(url: apiURL)
                    .map { $0.results.map { $0.posterPath }}
                    .subscribe(onNext: { [weak self] posterList in
                        self?.output.posterList.accept(posterList)
                    })
                    .disposed(by: self!.disposeBag)
            }).disposed(by: disposeBag)
    }
    
    
}
