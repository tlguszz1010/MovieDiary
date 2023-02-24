//
//  WriteViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/20.
//

import UIKit
import RealmSwift

final class WriteViewController: UIViewController {
    private let mainView = WriteView()
    private let localRealm = try? Realm()
    private var tasks: Results<DiaryList>!
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 배열에 Realm의 데이터 초기화
        guard let localRealm = localRealm else { return }
        tasks = localRealm.objects(DiaryList.self).sorted(byKeyPath: "writeDay", ascending: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        navigationUI()
    }
    
    private func navigationUI() {
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        navigationItem.rightBarButtonItem = completeButton
        completeButton.tintColor = .black
    }
    
    @objc func completeButtonClicked() {
        var task = DiaryList()
        guard let localRealm = localRealm else { return }
        task = DiaryList(text: mainView.textView.text, writeDay: Date())
        try? localRealm.write {
            localRealm.add(task)
            print("Realm Succedd")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
}
