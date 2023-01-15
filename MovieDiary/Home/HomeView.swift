//
//  HomeView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    let movieCollectionView : UICollectionView = {
        let view = UICollectionViewFlowLayout()
        view.minimumLineSpacing = 1
        view.minimumInteritemSpacing = 1
        view.scrollDirection = .vertical
        view.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let myWidth: CGFloat = UIScreen.main.bounds.width
        view.itemSize = CGSize(width: myWidth, height: myWidth / 1.7)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: view)
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.backgroundColor = .white
        return collection
    }()
    
    override func makeConfigures() {
        self.addSubview(movieCollectionView)
    }
    
    override func makeConstraints() {
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


