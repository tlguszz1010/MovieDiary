//
//  SearchViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/05.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    struct Input {
        let searchTrigger: PublishSubject<String?> = PublishSubject()
    }
    
    struct Output {
        var dataList: BehaviorRelay<[ResultModel]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputSubcribe()
    }
    
    private func inputSubcribe() {
        self.input.searchTrigger
            .subscribe(onNext: {[weak self] text in
                guard let disposeBag = self?.disposeBag else { return }
                guard let text = text else { return }
                let beforeEncodingURL = BaseURL.searchURL + APIKey.TMDB + EndPoint.language + EndPoint.query + text
                guard let afterEncodingURL = beforeEncodingURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
                HomeAPIManager.shared.getHomeAPIWithRx(url: afterEncodingURL)
                    .map { $0.results.map { $0 }}
                    .subscribe(onNext: { [weak self] dataList in
                        self?.output.dataList.accept(dataList)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
