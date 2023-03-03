//
//  HomeCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    let viewModel = CellViewModel()
    private let disposeBag = DisposeBag()
    private let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = HomeInsideFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        self.backgroundColor = .black
        collectionView.backgroundColor = .black
        collectionViewUI()
        collectionView.contentInsetAdjustmentBehavior = .never
        dataSource()
    }
    
    private func collectionViewUI() {
        collectionView.delegate = self
        collectionView.register(HomeInsideCollectionViewCell.self, forCellWithReuseIdentifier: HomeInsideCollectionViewCell.identifier)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func dataSource() {
        // idx - row, ele - element, cell - cell
        viewModel.output.posterList
            .bind(to: collectionView.rx.items(cellIdentifier: HomeInsideCollectionViewCell.identifier, cellType: HomeInsideCollectionViewCell.self)) { _, ele, cell in
                cell.image.kf.setImage(with: URL(string: BaseURL.baseImageURL + ele))
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.size.width / 3, height: 200)
    }
}
