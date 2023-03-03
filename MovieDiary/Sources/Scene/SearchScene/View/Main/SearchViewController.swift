//
//  SearchViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

/// 🏮 final
final class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel() // DI

    private let mainView = SearchView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar()
        configureCell()
        bind()
        didSelected()
        navigationUI()
    }
    
    private func navigationUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func configureCell() {
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    private func bind() {
        viewModel.output.dataList
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: SearchResultCollectionViewCell.identifier, cellType: SearchResultCollectionViewCell.self)) { _, ele, cell in
                
                // configure 매서드들 cell 에서 처리 -> VC에서 titleLabel, releaseDateLabel을 작성해주는게 나을지
                cell.configure(with: ele)
            }
            .disposed(by: disposeBag)
    }
    
    func test() {
        
    }
    
    private func didSelected() {
        mainView.collectionView.rx
            .modelSelected(ResultModel.self)
            .map { $0.id }
            .subscribe(onNext: { [weak self] id in
                guard let self = self else { return }
                let detailVC = SearchDetailViewController()
                detailVC.viewModel.input.viewDidLoadTrigger.onNext(id)
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
   
    private func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화를 검색해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.rx.text
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            // -> text 입력이 끝났을 때 (Enter 눌렀을 때)
            .subscribe(onNext: { [weak self] _ in
                guard let text = searchController.searchBar.text else { return }
                self?.viewModel.input.searchTrigger.onNext(text)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        mainView.collectionView.reloadData()
    }
}
