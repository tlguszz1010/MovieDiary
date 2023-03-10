//
//  CalendarView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/10.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarView: BaseView {
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()

    override func makeConfigures() {
        self.addSubview(calendar)
    }
    
    override func makeConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
}
