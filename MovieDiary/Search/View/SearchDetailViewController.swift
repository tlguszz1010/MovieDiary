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

class SearchDetailViewController: UIViewController {
    
    let mainView = SearchDetailView()
    let viewModel = SearchDetailViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        viewModel.output.idData
            .filter {$0 != nil}
            .subscribe(onNext: {[weak self] data in
                guard let data = data else { return }
                self?.mainView.posterImageView.kf.setImage(with: URL(string: BaseURL.baseImageURL + data.backdropPath))
                self?.mainView.overViewLabel.text = data.overview
            })
            .disposed(by: disposeBag)
    }
    
    func configureCell() {
        mainView.castCollectionView.delegate = self
        mainView.castCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        mainView.castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
    }
}

extension SearchDetailViewController: UICollectionViewDelegate {
    
}

extension SearchDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.castCollectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
