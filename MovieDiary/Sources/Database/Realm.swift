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
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(text: String, writeDay: Date) {
        self.init()
        self.allText = text
        self.writeDay = writeDay
    }
}

// 즐겨찾기 추가 된 영화 리스트
class BookMarkList: Object {
    @Persisted var movieID: Int?
    
    convenience init(id: Int) {
        self.init()
        self.movieID = id
    }
}
