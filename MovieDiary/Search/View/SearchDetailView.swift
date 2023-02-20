//
//  SearchDetailView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/13.
//

import UIKit
import SnapKit

class SearchDetailView: BaseView {
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let overViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
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
        view.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: view)
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collection
    }()
    
    override func makeConfigures() {
        self.backgroundColor = .white
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [posterImageView, overViewLabel, castLabel, castCollectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(castLabel.snp.top).offset(-20)
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
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }
}
