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
        view.backgroundColor = .black
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
        view.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 4)
        view.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: view)
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
    
    override func makeConfigures() {
        self.backgroundColor = .white
        [backView, overViewLabel, castLabel, castCollectionView].forEach {
            contentView.addSubview($0)
        }
        [posterImageView, bookMarkButton].forEach {
            backView.addSubview($0)
        }
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(4)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().offset(10)
            make.width.equalTo(scrollView.snp.width)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
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
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        castCollectionView.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
    }
}
