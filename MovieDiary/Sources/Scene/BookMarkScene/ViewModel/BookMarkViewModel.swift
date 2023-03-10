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
        let realmFetchData: PublishSubject<[RealmData]> = PublishSubject()
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
    private let disposeBag = DisposeBag()
    private var notificationToken: NotificationToken?
    var dataResult: Results<BookMarkList>?
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        viewDidLoadTrigger()
        dataResult = localRealm?.objects(BookMarkList.self)
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    // MARK: - Realm에서 저장된 데이터 (ID,Title,Poster,ReleaseDate) 를 가져와서 각각의 List에 넣어주고, BookMarkVC로 Emit. -> BookMarkVC에서 Cell에 그리기
    
    private func viewDidLoadTrigger() {
        // MARK: - ViewDidLoadTrigger: 뷰가 로드되고나면 현재까지 렘에 있는 데이터를 그려준다.
        self.input.viewDidLoadTrigger
            .subscribe(onNext: { _ in
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
            })
            .disposed(by: disposeBag)
//        notificationToken = dataResult?.observe {[weak self] changes in
//            switch changes {
//            case .initial(let datas):
//                print("✅✅✅ 최초의 데이터 \(datas)")
//            case .error(let error):
//                print("✅✅✅ 에러 \(error)")
//            case .update(let users, _, _, _):
//                print("✅✅✅ 바뀐 데이터 \(users)")
//            }
//        }
        // MARK: - 렘의 Notification을 감지 -> 렘의 데이터가 변경되었을 때 호출된다 -> 근데 이게 좋은방법인가? 왜냐하면 변경되었을 때 변경된것만 보내서 추가하는게 아니라 모든 데이터를 한번에 다시 보내고 있기 때문이다.
        notificationToken = localRealm?.observe { [weak self] _, _ in
            print("데이터 변화 감지 🎾🎾🎾")
            guard let self = self else { return }
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
}
