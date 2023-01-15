//
//  HomeCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    let image : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
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
