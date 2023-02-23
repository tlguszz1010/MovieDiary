//
//  Realm.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/23.
//

import Foundation
import RealmSwift

class DiaryList: Object {
    @Persisted var allText: String?
    @Persisted var writeDay: Date
    
    init(text: String, writeDay: Date) {
        self.allText = text
        self.writeDay = writeDay
    }
}
