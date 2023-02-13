//
//  SearchDetailView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/13.
//

import UIKit
import SnapKit

class SearchDetailView: BaseView {
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()
    
    let overViewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemMint
        return label
    }()
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "출연진"
        return label
    }()
    
    let castCollectionView: UICollectionView = {
        let view = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: view)
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.backgroundColor = .green
        return collection
    }()
    
    
    
    override func makeConfigures() {
        self.backgroundColor = .white
        [posterImageView, overViewLabel, castLabel, castCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(castLabel.snp.top).offset(-10)
        }
        
        
        castLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalTo(castCollectionView.snp.top).offset(-10)
        }
        
        castCollectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
}
