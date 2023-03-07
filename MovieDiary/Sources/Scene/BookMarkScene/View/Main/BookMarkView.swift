//
//  BookMarkView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/07.
//

import UIKit
import SnapKit

final class BookMarkView: BaseView {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 3.5)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .black
        return view
    }()
    
    override func makeConfigures() {
        self.addSubview(collectionView)
    }
    
    override func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
