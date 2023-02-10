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
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func dataSource() {
        viewModel.output.titleList
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: SearchResultCollectionViewCell.identifier, cellType: SearchResultCollectionViewCell.self)) { _, ele, cell in
                cell.titleLabel.text = ele
            }
            .disposed(by: disposeBag)
    }
    
}

