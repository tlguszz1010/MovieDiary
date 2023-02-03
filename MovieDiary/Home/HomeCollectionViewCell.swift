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
        viewModel.output.posterList
            .filter{ $0 != nil } // BehaviorRelay는 bindAndFire라고 생각하면 됨
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in // VM에서 output의 데이터가 바뀜을 감지하고 컬렉션 뷰 리로드
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        self.backgroundColor = .systemPink
    }
    
    func collectionViewUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeInsideCollectionViewCell.self, forCellWithReuseIdentifier: HomeInsideCollectionViewCell.identifier)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension HomeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // BehaviorRelay로 posterList를 초기화 -> 값을 가져다 쓰려면 .value를 사용해야됨
        return self.viewModel.output.posterList.value?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeInsideCollectionViewCell.identifier, for: indexPath) as! HomeInsideCollectionViewCell
        cell.image.kf.setImage(with: URL(string: BaseURL.baseImageURL + (self.viewModel.output.posterList.value?[indexPath.row])!))
        
        return cell
    }
}

extension HomeCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.size.width / 3, height: 200)
    }
}
