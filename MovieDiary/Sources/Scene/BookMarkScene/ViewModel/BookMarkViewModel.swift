//
//  BookMarkViewModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/07.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class BookMarkViewModel: BaseViewModel {
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        var realmData: BehaviorRelay<[RealmData]> = BehaviorRelay(value: [])
    }
    
    struct RealmData {
        let id: Int?
        let posterPath: String?
        let title: String?
        let releaseDate: String?
    }
    
    var input: Input
    var output: Output
    private var idList: [Int] = []
    private var posterList: [String] = []
    private var titleList: [String] = []
    private var releaseDateList: [String] = []
    private let localRealm = try? Realm()
    private var bookmarkList: [BookMarkList] = []
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        viewDidLoadTrigger()
    }
    
    // MARK: - Realm에서 저장된 데이터 (ID,Title,Poster,ReleaseDate) 를 가져와서 각각의 List에 넣어주고, BookMarkVC로 Emit. -> BookMarkVC에서 Cell에 그리기
    private func viewDidLoadTrigger() {
        guard let bookmarkData = self.localRealm?.objects(BookMarkList.self) else { return }
        var bookmarkDataArray = [RealmData]()
        for bookmark in bookmarkData {
            guard let id = bookmark.movieID else { continue }
            guard let poster = bookmark.moviePosterPath else { continue }
            guard let title = bookmark.movieTitle else { continue }
            guard let releaseDate = bookmark.movieReleaseDate else { continue }
            let bookmarkData = RealmData(id: id, posterPath: poster, title: title, releaseDate: releaseDate)
            bookmarkDataArray.append(bookmarkData)
        }
        self.output.realmData.accept(bookmarkDataArray)
    }
}
