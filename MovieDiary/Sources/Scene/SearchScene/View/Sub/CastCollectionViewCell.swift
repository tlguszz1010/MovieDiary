//
//  CastCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/13.
//

import UIKit
import SnapKit

final class CastCollectionViewCell: UICollectionViewCell {
    static let identifier = "CastCollectionViewCell"
    
    let castImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        return image
    }()
    
    let castName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let castStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUPView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUPView() {
        addSubview(castStackView)
        [castImage, castName].forEach {
            castStackView.addArrangedSubview($0)
        }
        castStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        castName.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

    }
}
