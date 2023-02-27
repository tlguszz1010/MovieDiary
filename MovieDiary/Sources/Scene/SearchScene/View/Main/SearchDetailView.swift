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
        var bookMarkconfig = UIButton.Configuration.filled()
        bookMarkconfig.image = UIImage(systemName: "star.fill")
        bookMarkconfig.baseForegroundColor = UIColor.black
        bookMarkconfig.baseBackgroundColor = UIColor.white
        bookMarkconfig.background.strokeColor = .black
        bookMarkconfig.background.strokeWidth = 1
        bookMarkconfig.background.cornerRadius = 5
        bookMarkconfig.imagePlacement = .trailing
        bookMarkconfig.imagePadding = 5
        var bookmarkTitle = AttributedString.init("즐겨찾기")
        bookmarkTitle.font = UIFont.systemFont(ofSize: 15)
        bookMarkconfig.attributedTitle = bookmarkTitle
        let button = UIButton()
        button.configuration = bookMarkconfig
        return button
    }()
    
    let diaryButton: UIButton = {
        var diaryTitle = AttributedString.init("기록하기")
        diaryTitle.font = UIFont.systemFont(ofSize: 15)
        var diaryconfig = UIButton.Configuration.filled()
        diaryconfig.imagePlacement = .trailing
        diaryconfig.imagePadding = 5
        diaryconfig.baseBackgroundColor = UIColor.white
        diaryconfig.attributedTitle = diaryTitle
        diaryconfig.background.strokeColor = .black
        diaryconfig.background.strokeWidth = 1
        diaryconfig.background.cornerRadius = 5
        diaryconfig.image = UIImage(systemName: "pencil")
        diaryconfig.baseForegroundColor = UIColor.black
        let button = UIButton()
        button.configuration = diaryconfig
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    // 하이라키 네이밍 Set
    override func makeConfigures() {
        self.backgroundColor = .white
        [bookMarkButton, diaryButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [posterImageView, buttonStackView].forEach {
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
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.horizontalEdges.equalToSuperview()
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
