//
//  BaseView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
        backgroundColor = .white

    }
    
    func makeConfigures() {}
    func makeConstraints() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
