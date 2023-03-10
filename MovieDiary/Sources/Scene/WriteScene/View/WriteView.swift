//
//  WriteView.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/20.
//

import UIKit
import SnapKit

final class WriteView: BaseView {
    let textView: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        self.addSubview(textView)
    }
    
    override func makeConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }

}
