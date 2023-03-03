//
//  SearchResultCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/06.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchResultCollectionViewCell"
    let totalView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 제목"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 개봉일"
        label.textColor = .white
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
        
        [posterImage, labelStackView].forEach {
            totalView.addSubview($0)
        }
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(releaseDateLabel)

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
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(posterImage.snp.trailing).offset(20)
        }
    }
    func configure(with item: ResultModel) {
        posterImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + item.posterPath))
        releaseDateLabel.text = item.releaseDate
        titleLabel.text = item.title
    }
}
