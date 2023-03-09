//
//  BookMarkCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/07.
//

import UIKit

class BookMarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookMarkCollectionViewCell"
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
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let writeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        var titleAttr = AttributedString.init("기록하기")
        titleAttr.font = .systemFont(ofSize: 12, weight: .regular)
        config.attributedTitle = titleAttr
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "pencil")
        let button = UIButton(configuration: config)
        return button
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
        
        [posterImage, labelStackView, writeButton].forEach {
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
            make.height.equalToSuperview().multipliedBy(0.5)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(posterImage.snp.trailing).offset(20)
        }
        
        writeButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    func configure(with item: ResultModel) {
        posterImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + item.posterPath))
        releaseDateLabel.text = item.releaseDate
        titleLabel.text = item.title
    }
}
