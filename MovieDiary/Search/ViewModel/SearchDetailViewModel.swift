//
//  SearchDetailViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/14.
//

import Foundation
import RxSwift
import RxCocoa

class SearchDetailViewModel: BaseViewModel {
    struct Input {
        let viewDidLoadTrigger: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    }
    
    struct Output {
        var idData: BehaviorRelay<ResponseDetailData?> = BehaviorRelay(value: nil)
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        initialTrigger()
    }
    
    private func initialTrigger() {
        self.input.viewDidLoadTrigger
            .subscribe(onNext: {[weak self] id in
                guard let disposeBag = self?.disposeBag else { return }
                HomeAPIManager.shared.getDetailMovieAPI(id: id)
                    .subscribe(onNext: { [weak self] detailData in
                        self?.output.idData.accept(detailData)
                        print(detailData)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
