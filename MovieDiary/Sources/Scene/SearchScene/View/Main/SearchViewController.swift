//
//  SearchViewController.swift
//  MovieDiary
//
//  Created by ๋ฐ์ํ on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

///ย ๐ฎ final
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
                
                // configure ๋งค์๋๋ค cell ์์ ์ฒ๋ฆฌ -> VC์์ titleLabel, releaseDateLabel์ ์์ฑํด์ฃผ๋๊ฒ ๋์์ง
                cell.configure(with: ele)
            }
            .disposed(by: disposeBag)
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
        searchController.searchBar.placeholder = "์ํ๋ฅผ ๊ฒ์ํด์ฃผ์ธ์"
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
            // -> text ์๋ ฅ์ด ๋๋ฌ์ ๋ (Enter ๋๋ ์ ๋)
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
