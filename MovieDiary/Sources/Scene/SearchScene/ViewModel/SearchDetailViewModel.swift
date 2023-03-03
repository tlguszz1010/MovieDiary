//
//  SearchDetailViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/14.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class SearchDetailViewModel: BaseViewModel {
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Int> = PublishSubject()
        let bookMarkButtonClicked: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    }
    
    struct Output {
        var idData: BehaviorRelay<ResponseDetailData?> = BehaviorRelay(value: nil)
        var cast: BehaviorRelay<[Cast]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    private let localRealm = try? Realm()
    private var tasks: Results<DiaryList>?
    
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
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        self.input.viewDidLoadTrigger
            .subscribe(onNext: {[weak self] id in
                guard let disposeBag = self?.disposeBag else { return }
                HomeAPIManager.shared.getCreidts(id: id)
                    .map { $0.cast }
                    .subscribe(onNext: { [weak self] cast in
                        print(cast)
                        self?.output.cast.accept(cast)
                        
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        self.input.bookMarkButtonClicked
            .subscribe(onNext: {[weak self] _ in
                guard let disposeBag = self?.disposeBag else { return }
                
            })
            .disposed(by: disposeBag)
    }
}
