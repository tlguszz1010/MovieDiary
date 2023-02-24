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
        view.backgroundColor = .white
        searchBar()
        configureCell()
        bindDataSource()
        didSelected()
        navigationUI()
    }
    
    private func navigationUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func configureCell() {
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    private func bindDataSource() {
        viewModel.output.dataList
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: SearchResultCollectionViewCell.identifier, cellType: SearchResultCollectionViewCell.self)) { _, ele, cell in
                
                // --> configure 매서드들 cell 에서 처리
                //cell.configure(with: <#T##ResultModel#>)
                cell.posterImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + ele.posterPath))
                cell.releaseDateLabel.text = ele.releaseDate
                cell.titleLabel.text = ele.title
            }
            .disposed(by: disposeBag)
    }
    
    private func didSelected() {
        mainView.collectionView.rx
            .modelSelected(ResultModel.self)
            .map { $0.id }
            .subscribe(onNext: { [weak self] id in
                //guard let self = self else { self } --> 선 차단
                guard let self = self else { return }
                let detailVC = SearchDetailViewController()
                detailVC.viewModel.input.viewDidLoadTrigger.onNext(id)
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: self.disposeBag) //self
        self.mainView.collectionView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
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

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.rx.text // -> text 입력이 끝났을 때 (Enter 눌렀을 때)
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
