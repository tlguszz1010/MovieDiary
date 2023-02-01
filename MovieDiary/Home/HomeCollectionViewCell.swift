//
//  HomeCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    let api = Repository()
    let viewModel = cellViewModel()
    
    let collectionView : UICollectionView
    
    override init(frame: CGRect) {
        let layout = HomeInsideFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        viewModel.input.initTrigger.value = collectionViewUI()
        viewModel.output.data.bind { [weak self] _ in // VM에서 output의 데이터가 바뀜을 감지하고 컬렉션 뷰 리로드
            self?.collectionView.reloadData()
        }
        self.backgroundColor = .systemPink
    }
    
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        posterList.removeAll()
//    }
    
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
        return self.viewModel.posterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeInsideCollectionViewCell.identifier, for: indexPath) as! HomeInsideCollectionViewCell
        cell.image.kf.setImage(with: URL(string: BaseURL.baseImageURL + self.viewModel.posterList[indexPath.row]))
        
        return cell
    }
}

extension HomeCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.size.width / 3, height: 200)
    }
}
