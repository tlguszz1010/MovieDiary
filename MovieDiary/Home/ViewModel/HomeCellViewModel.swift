//
//  HomeCellViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/02.
//

import Foundation
import RxSwift
import RxCocoa

class CellViewModel: BaseViewModel {
    // View로부터 받은 요청
    struct Input {
        let initTrigger: PublishSubject<Int> = PublishSubject()
    }
    // View에서 사용할 데이터
    struct Output {
        let posterList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    }
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBinding()
    }
    // View에서 input값이 바뀌었을 때 감지하는 메서드
    // 뷰모델 -> Model(BaseURL + EndPoint)을 가지고 있어야함
    private func inputBinding() {
        self.input.initTrigger
            .subscribe(onNext: { [weak self] sec in
                HomeAPIManager.shared.getHomeAPIWithRx(url: APIIndex(rawValue: sec)!.sectionURL)
                    .map { $0.results.map { $0.posterPath }}
                    .subscribe(onNext: { [weak self] posterList in
                        self?.output.posterList.accept(posterList)
                    })
                    .disposed(by: self!.disposeBag)
            }).disposed(by: disposeBag)
    }
}
