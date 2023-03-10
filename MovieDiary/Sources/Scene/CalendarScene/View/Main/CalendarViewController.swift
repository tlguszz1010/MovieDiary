//
//  CalendarViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/05.
//

import UIKit
import FSCalendar
import RxSwift

class CalendarViewController: UIViewController {
    let mainView = CalendarView()
    let viewModel = CalendarViewModel()
    private var events: [Date]?
    private var flag: Bool = false
    private let disposeBag = DisposeBag()
    private var recordedCount: Int = 0
    private var recordedDateArray: [Date] = []
    
    override func loadView() {
        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordedDate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadTrigger()
        configureCalendar()
    }
    
    private func viewDidLoadTrigger() {
        viewModel.input.calendarViewDidLoadTrigger.onNext(())
    }
    
    private func configureCalendar() {
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.calendar.backgroundColor = .white
        mainView.calendar.appearance.eventDefaultColor = .darkGray
    }
    
    private func recordedDate() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        viewModel.output.writeDate
            .subscribe(onNext: {[weak self] dateList in
                print("▶️▶️")
                guard let self = self else { return }
                
                self.events = dateList
                guard let events = self.events else { return }
                for ele in events {
                    let dateToStr = formatter.string(from: ele)
                    self.recordedDateArray.append(formatter.date(from: dateToStr) ?? Date())
                }
                print("넘어온 기록 날짜들은 \(self.recordedDateArray) 이거야 0️⃣0️⃣0️⃣")
            })
            .disposed(by: disposeBag)
    }
}

extension CalendarViewController: FSCalendarDelegate {
   
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.recordedDateArray.contains(date) {
            return 1
        }
        return 0
    }
}

extension CalendarViewController: FSCalendarDelegateAppearance {
    
}
