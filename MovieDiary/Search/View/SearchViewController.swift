//
//  SearchViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    let viewModel = SearchViewModel()
    let mainView = SearchView()
    let disposeBag = DisposeBag()
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    func configureUI() {
        searchBar()
        configureCell()
    }
    func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화를 검색해주세요"
        searchController.searchBar.rx.textDidEndEditing // -> text 입력이 끝났을 때 (Enter 눌렀을 때)
            .subscribe(onNext: { [weak self] _ in
                guard let text = searchController.searchBar.text else { return }
                self?.viewModel.input.searchTrigger.onNext(text)
            })
            .disposed(by: disposeBag)
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    func configureCell() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // 섹션은 한개만 있으면 됨. -> 한 섹션안에서 해당하는 데이터 다 보여줄 예정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 서치에 해당하는 영화의 갯수만큼 item 가지고 있어야됨 -> 서치에 해당하는 item을 빈 List에 넣어줘야겠지? -> 그 List의 Count만큼 반환
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        cell.totalView.backgroundColor = .blue
        return cell
    }
}
