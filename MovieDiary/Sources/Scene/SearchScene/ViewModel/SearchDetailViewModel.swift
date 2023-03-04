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
        let bookMarkButtonTrigger: PublishSubject<Int> = PublishSubject()
        let deleteDataTrigger: PublishSubject<Bool> = PublishSubject()
        let addDataTrigger: PublishSubject<Bool> = PublishSubject()
    }
    
    struct Output {
        var idData: BehaviorRelay<ResponseDetailData?> = BehaviorRelay(value: nil)
        var cast: BehaviorRelay<[Cast]> = BehaviorRelay(value: [])
        var bookMarkState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        
    }
    
    var input: Input
    var output: Output
    
    private let disposeBag = DisposeBag()
    private let localRealm = try? Realm()
    private var tasks: Results<BookMarkList>?
    private var task = BookMarkList()
    private var id: Int?
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        initialTrigger()
        bookMarkTrigger()
    }
    
    private func bookMarkTrigger() {
        self.input.bookMarkButtonTrigger
            .subscribe(onNext: {[weak self] id in
                // 1. Realm에 title 추가
                // 2. Realm에 title이 있는지 판단,
                // 3. Bool 타입으로 View에 넘기기.
                guard let self = self else { return }
                self.id = id
                let tasks = self.localRealm?.objects(BookMarkList.self).filter("movieID == \(id)")
                if let _ = tasks?.first?.movieID {
                    self.output.bookMarkState.accept(true)
                } else {
                    self.output.bookMarkState.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        self.input.deleteDataTrigger
            .subscribe(onNext: {[weak self] checkFlag in
                if checkFlag {
                    // 삭제 O
                } else {
                    // 삭제 X
                }
            })
            .disposed(by: disposeBag)
        self.input.addDataTrigger
            .subscribe(onNext: {[weak self] checkFlag in
                if checkFlag {
                    // 추가 O
                    guard let self else { return }
                    self.task = BookMarkList(id: self.id ?? 0)
                    try? self.localRealm?.write {
                        self.localRealm?.add(self.task)
                        print("Realm Succedd 🥇🥇🥇")
                    }
                } else {
                    // 추가 X
                }
            })
            .disposed(by: disposeBag)
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
    }
}
