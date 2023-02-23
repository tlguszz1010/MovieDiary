//
//  HomeCollectionHeaderView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/15.
//

import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {
    static let identifier = "HomeCollectionHeaderView"
    let headerViewModel = HomeCollectionViewHeaderViewModel()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    func configureHeaderView() {
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
}
