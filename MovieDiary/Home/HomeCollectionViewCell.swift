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

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    let viewModel = cellViewModel()
    let disposeBag = DisposeBag()
    let collectionView : UICollectionView
    
    override init(frame: CGRect) {
        
        let layout = HomeInsideFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        collectionViewUI()
        dataSource()
        viewModel.output.posterList
            .filter { $0 != [] }// BehaviorRelay는 bindAndFire라고 생각하면 됨
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in // VM에서 output의 데이터가 바뀜을 감지하고 컬렉션 뷰 리로드
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.backgroundColor = .systemPink
    }
    
    func collectionViewUI() {
        collectionView.delegate = self
        collectionView.register(HomeInsideCollectionViewCell.self, forCellWithReuseIdentifier: HomeInsideCollectionViewCell.identifier)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func dataSource() {
        viewModel.output.posterList
            .bind(to: collectionView.rx.items(cellIdentifier: HomeInsideCollectionViewCell.identifier, cellType: HomeInsideCollectionViewCell.self)) { idx, ele, cell in
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
