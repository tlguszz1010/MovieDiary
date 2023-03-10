//
//  CalendarViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/05.
//

import UIKit

class CalendarViewController: UIViewController {
    let mainView = CalendarView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
