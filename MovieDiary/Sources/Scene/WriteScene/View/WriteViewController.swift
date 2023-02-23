//
//  WriteViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/20.
//

import UIKit

final class WriteViewController: UIViewController {
    private let mainView = WriteView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
    }
    
    private func navigationUI() {
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        navigationItem.rightBarButtonItem = completeButton
        completeButton.tintColor = .black
    }
    
    @objc func completeButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
