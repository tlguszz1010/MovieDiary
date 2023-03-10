//
//  BookMarkViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/03/05.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import RealmSwift

class BookMarkViewController: UIViewController {
    
    let mainView = BookMarkView()
    let viewModel = BookMarkViewModel()
    var movieID: Int = 0
    var movieTitle: String = ""
    private let disposeBag = DisposeBag()
    private let localRealm = try? Realm()
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - ViewModel 시작
        viewModel.input.viewDidLoadTrigger.onNext(())
        registerCell()
        configureCell()
    }
    
    private func registerCell() {
        mainView.collectionView.register(BookMarkCollectionViewCell.self, forCellWithReuseIdentifier: BookMarkCollectionViewCell.identifier)
    }
    
    private func configureCell() {
        viewModel.output.realmData
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: BookMarkCollectionViewCell.identifier, cellType: BookMarkCollectionViewCell.self)) {indexPath, ele, cell in
                guard let posterPath = ele.posterPath else { return }
                guard let title = ele.title else { return }
                guard let releaseDate = ele.releaseDate else { return }
                cell.posterImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + posterPath))
                cell.releaseDateLabel.text = releaseDate
                cell.titleLabel.text = title
                cell.writeButton.tag = indexPath
                print("indexPath야 \(indexPath) 💯💯💯")
                cell.writeButton.addTarget(self, action: #selector(self.writeButtonClicked), for: .touchUpInside)
                
            }
            .disposed(by: disposeBag)
    }
    @objc func writeButtonClicked(sender: UIButton) {
        let writeVC = WriteViewController()
        writeVC.hidesBottomBarWhenPushed = true
        
        let index = sender.tag
        print("버튼의 tag는 ? \(index)야 💜💜💜")
        let ele = viewModel.output.realmData.value[index]
        print("해당하는 index의 realmData는 \(ele)야 💛💛💛")
        guard let id = ele.id else { return }
        writeVC.movieID = id
        print("넘긴 movieID는 \(id) 💢💢💢")
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
}
