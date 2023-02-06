//
//  HomeInsideCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/15.
//

import UIKit
import SnapKit

class HomeInsideCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeInsideCollectionViewCell"
    let image : UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
