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
    private var task = DiaryList()
    var movieID: Int = 0
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 배열에 Realm의 데이터 초기화
        guard let localRealm = localRealm else { return }
        tasks = localRealm.objects(DiaryList.self).sorted(byKeyPath: "writeDay", ascending: false)
        storedDiaryContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        navigationUI()
    }
    
    private func navigationUI() {
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        completeButton.tintColor = .black
        navigationItem.rightBarButtonItem = completeButton
    }
    
    private func storedDiaryContent() {
        let task = localRealm?.objects(DiaryList.self)
        let contents = task?.filter("movieId == \(movieID)")
        guard let allText = contents?.first?.allText else { return }
        mainView.textView.text = allText
    }
    
    @objc func completeButtonClicked() {
        guard let localRealm = localRealm else { return }
        var tasks = localRealm.objects(DiaryList.self).filter("movieId=\(movieID)").count
        if tasks == 0 {
            task = DiaryList(text: mainView.textView.text, writeDay: Date(), id: movieID)
            // MARK: - Realm ADD
            try? localRealm.write {
                localRealm.add(task)
            }
        } else {
            // MARK: - Realm Update
            let updateContent = localRealm.objects(DiaryList.self).filter("movieId=\(movieID)").first
            try? localRealm.write {
                updateContent?.allText = mainView.textView.text
            }
        }
        self.navigationController?.popViewController(animated: true)
        
    }
}
