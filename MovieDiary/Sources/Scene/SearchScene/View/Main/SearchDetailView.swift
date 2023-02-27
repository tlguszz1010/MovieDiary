//
//  SearchDetailView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/13.
//

import UIKit
import SnapKit

final class SearchDetailView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .red
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let overViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        label.text = "출연진"
        return label
    }()
    
    let castCollectionView: UICollectionView = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: view)
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.backgroundColor = .black
        return collection
    }()
    
    let bookMarkButton: UIButton = {
        var bookMarkConfig = UIButton.Configuration.filled()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        bookMarkConfig.image = UIImage(systemName: "star")
        bookMarkConfig.baseForegroundColor = UIColor.black
        bookMarkConfig.baseBackgroundColor = UIColor.white
        bookMarkConfig.background.strokeColor = .black
        bookMarkConfig.background.strokeWidth = 1
        bookMarkConfig.background.cornerRadius = 5
        bookMarkConfig.imagePlacement = .trailing
        bookMarkConfig.imagePadding = 5
        bookMarkConfig.preferredSymbolConfigurationForImage = imageConfig
        let button = UIButton()
        button.configuration = bookMarkConfig
        return button
    }()
    // 하이라키 네이밍 Set
    override func makeConfigures() {
        self.backgroundColor = .white
        
        [posterImageView, bookMarkButton].forEach {
            backView.addSubview($0)
        }
        
        [backView, overViewLabel, castLabel, castCollectionView].forEach {
            contentView.addSubview($0)
        }
        scrollView.addSubview(contentView)
        scrollView.contentInsetAdjustmentBehavior = .never
        self.addSubview(scrollView)
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
            make.horizontalEdges.equalToSuperview()
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom)
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
