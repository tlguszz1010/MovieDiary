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
        var posterList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
        var titleList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
        var releaseDateList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
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
                // API 호출 부분
                guard let text = text else { return }
                let beforeEncodingURL = BaseURL.searchURL + APIKey.TMDB + EndPoint.endPoint + EndPoint.query + text
                guard let afterEncodingURL = beforeEncodingURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
                print(afterEncodingURL)
                HomeAPIManager.shared.getHomeAPIWithRx(url: afterEncodingURL)
                    .map { $0.results.map { $0.originalTitle }}
                    .subscribe(onNext: { [weak self] titleList in
                        self?.output.titleList.accept(titleList)
                        print(titleList)
                    })
                    .disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
