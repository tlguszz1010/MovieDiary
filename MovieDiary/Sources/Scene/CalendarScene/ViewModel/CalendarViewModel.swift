//
//  CalendarViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/10.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class CalendarViewModel: BaseViewModel {
    struct Input {
        let calendarViewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        var writeDate: BehaviorRelay<[Date]?> = BehaviorRelay(value: [])    }
    
    var input: Input
    var output: Output
    private let localRealm = try? Realm()
    private let disposeBag = DisposeBag()
    private var notificationToken: NotificationToken?

    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        getWriteDate()
    }
    
    // MARK: - Fetch Realm write Date - 다이어리 날짜를 가져와서 View에 던져줌, view에서
    
    private func getWriteDate() {
        self.input.calendarViewDidLoadTrigger
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                let writeDateData = self.localRealm?.objects(DiaryList.self)
                    .map {$0.writeDay}
                    .sorted()
                self.output.writeDate.accept(writeDateData)
                print("기록한 날짜들은 \(writeDateData) 이거야 🅿️🅿️🅿️")
            })
            .disposed(by: disposeBag)
    }
}
