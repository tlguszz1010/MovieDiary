//
//  SearchResultCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/06.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchResultCollectionViewCell"
    let totalView: UIView = {
        let view = UIView()
        return view
    }()
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        return image
    }()
    
    let labelStaciView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 제목"
        label.textAlignment = .center
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 개봉일"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        contentView.addSubview(totalView)
        
        [posterImage, labelStaciView].forEach {
            totalView.addSubview($0)
        }
        
        labelStaciView.addArrangedSubview(titleLabel)
        labelStaciView.addArrangedSubview(releaseDateLabel)

    }
    
    func constraints() {
        totalView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.leading.equalToSuperview().offset(20)
        }
        
        labelStaciView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
    }
}

