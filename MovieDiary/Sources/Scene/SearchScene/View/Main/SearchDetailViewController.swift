//
//  SearchDetailViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import RealmSwift

final class SearchDetailViewController: UIViewController {
    private let mainView = SearchDetailView()
    let viewModel = SearchDetailViewModel()
    private let disposeBag = DisposeBag()
    private var currentMovieID: Int?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        bind()
        navigationUI()
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
    }
    private func navigationUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
    }
    private func configureCell() {
        mainView.castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
    }
    private func bind() {
        viewModel.output.idData
            .filter {$0 != nil}
            .subscribe(onNext: {[weak self] data in
                guard let data = data else { return }
                guard let self = self else { return }
                self.mainView.posterImageView.kf.setImage(with: URL(string: BaseURL.baseImageURL + data.backdropPath))
                self.mainView.overViewLabel.text = data.overview
                self.currentMovieID = data.id
            })
            .disposed(by: disposeBag)
        
        viewModel.output.cast
            .bind(to: mainView.castCollectionView.rx.items(cellIdentifier: CastCollectionViewCell.identifier, cellType: CastCollectionViewCell.self)) { _, ele, cell in
                cell.castImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + (ele.profilePath ?? "")))
                if ele.profilePath == nil {
                    cell.castImage.image = UIImage(named: "blankPerson")
                }
                cell.castName.text = ele.name
            }
            .disposed(by: disposeBag)
        
        //MARK: 북마크버튼: Realm에서 데이터 불러와서 true(즐겨찾기 되어 있는 경우), false로 분기처리 - true면 즐겨찾기 취소하시겠습니까 알럿, false인 경우 즐겨찾기 추가하시겠습니까?
        mainView.bookMarkButton.rx.tap
            .bind {
                //MARK: 해당 영화 title Emit
                self.viewModel.input.bookMarkButtonTrigger.onNext(self.currentMovieID ?? 0)
                // View에 관한 작업인가?
                self.viewModel.output.bookMarkState
                    .subscribe(onNext: {[weak self] bookMarkState in
                        guard let self = self else { return }
                        //MARK: 북마크 O
                        if bookMarkState {
                            let alert = UIAlertController(title: "알림", message: "즐겨찾기 목록에서 삭제 하시겠습니까?", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "네", style: .default) {_ in
                                self.viewModel.input.deleteDataTrigger.onNext(true)
                            }
                            let cancelAction = UIAlertAction(title: "아니오", style: .cancel) {_ in
                                // 삭제하지 않음 -> 아무일도 발생하지 않음
                                self.viewModel.input.deleteDataTrigger.onNext(false)
                            }
                            alert.addAction(okAction)
                            alert.addAction(cancelAction)
                            self.present(alert, animated: true, completion: nil)
                            //MARK: 북마크 X
                        } else {
                            let alert = UIAlertController(title: "알림", message: "즐겨찾기에 추가하시겠습니까?", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "네", style: .default) {_ in
                                // Realm의 즐겨찾기 목록에추가
                                // ViewModel로 보내서 -> 뷰모델에서 렘에 저장을 해준다.
                                // 버튼 이미지 색상을 fill로 수정 - UI 관련 작업
                                // "예" 눌렀을 때 해당 영화 데이터를 ViewModel로 전달 -> ViewModel에서 렘에 추가
                                // 여기서 해당하는 영화의 title만 어떻게 뽑지?
                                self.viewModel.input.addDataTrigger.onNext(true)
                            }
                            let cancelAction = UIAlertAction(title: "아니오", style: .cancel) {_ in
                                // 즐겨찾기 추가 x -> 아무일도 발생하지 않음
                                self.viewModel.input.addDataTrigger.onNext(false)
                            }
                            alert.addAction(okAction)
                            alert.addAction(cancelAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                    .disposed(by: self.disposeBag)
                
            }
            .disposed(by: disposeBag)
    }
}
