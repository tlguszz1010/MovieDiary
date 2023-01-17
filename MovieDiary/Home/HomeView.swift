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


