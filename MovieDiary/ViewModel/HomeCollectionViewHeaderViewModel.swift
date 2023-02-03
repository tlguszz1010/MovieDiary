//
//  HomeCollectionViewHeaderViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/03.
//

import Foundation
import RxSwift
import RxCocoa

class HomeCollectionViewHeaderViewModel: BaseViewInputOutput {
    struct Input {
        let initTrigger: PublishSubject<String?> = PublishSubject()
    }
    
    struct Output {
        let titleLabel: BehaviorRelay<String?> = BehaviorRelay(value: "")
    }
    
    var input: Input
    var output: Output
    let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputBinding()
    }
    
    private func inputBinding() {
        // 헤더뷰에서 데이터 방출할때 
        self.input.initTrigger
            .subscribe(onNext: { [weak self] title in
                self!.output.titleLabel.accept(title!)
            })
            .disposed(by: disposeBag)
    }
}
