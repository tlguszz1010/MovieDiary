//
//  HomeInsideFlowLayout.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/15.
//

import UIKit

class HomeInsideFlowLayout : UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
