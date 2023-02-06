//
//  SearchViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/05.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    struct Input {
        let searchTrigger: PublishSubject<String?> = PublishSubject()
    }
    
    struct Output {
        private var posterList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputSubcribe()
    }
    
    
    // SearchView에서 viewDidLoad가 동작될 때 실행
    private func inputSubcribe() {
        self.input.searchTrigger
        // searchTrigger에서 값을 emit할 때 ->
        // 받은 text를 통해 -> API 호출
            .subscribe(onNext: {[weak self] text in
                guard let text = text else { return }
                print(text)
            })
            .disposed(by: disposeBag)
    }
}
