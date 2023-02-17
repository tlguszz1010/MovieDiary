//
//  CastCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/13.
//

import UIKit
import SnapKit

class CastCollectionViewCell: UICollectionViewCell {
    static let identifier = "CastCollectionViewCell"
    
    let castImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        return image
    }()
}
