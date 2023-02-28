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

final class SearchDetailViewController: UIViewController {
    
    private let mainView = SearchDetailView()
    let viewModel = SearchDetailViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView() ///
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        bind()
        navigationUI()
    }
    private func navigationUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
    }
    private func configureCell() {
        mainView.castCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        mainView.castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
    }
    private func bind() { // 다형성 --> bind()
        viewModel.output.idData
            .filter {$0 != nil}
            .subscribe(onNext: {[weak self] data in
                guard let data = data else { return }
                 ///
                self?.mainView.posterImageView.kf.setImage(with: URL(string: BaseURL.baseImageURL + data.backdropPath))
                self?.mainView.overViewLabel.text = data.overview
            })
            .disposed(by: disposeBag)
        
        viewModel.output.cast
            .bind(to: mainView.castCollectionView.rx.items(cellIdentifier: CastCollectionViewCell.identifier, cellType: CastCollectionViewCell.self)) { _, ele, cell in
                cell.castImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + (ele.profilePath ?? "")))
                if ele.profilePath == nil {
                    ///
                    cell.castImage.image = UIImage(named: "blankPerson")
                }
                cell.castName.text = ele.name
            }
            .disposed(by: disposeBag)
        
        mainView.bookMarkButton.rx.tap
            .bind {
                
            }
            .disposed(by: disposeBag)
    }
}
extension SearchDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width / 3, height: view.frame.size.height / 4)
    }
}
