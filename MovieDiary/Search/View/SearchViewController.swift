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

class SearchViewController: UIViewController, UICollectionViewDelegate {
    let viewModel = SearchViewModel()
    let mainView = SearchView()
    let disposeBag = DisposeBag()
    var data: ResponseDetailData?
    
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
    }
    
    func configureCell() {
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func bindDataSource() {
        viewModel.output.dataList
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: SearchResultCollectionViewCell.identifier, cellType: SearchResultCollectionViewCell.self)) { _, ele, cell in
                cell.posterImage.kf.setImage(with: URL(string: BaseURL.baseImageURL + ele.posterPath))
                cell.releaseDateLabel.text = ele.releaseDate
                cell.titleLabel.text = ele.title
            }
            .disposed(by: disposeBag)
    }
    
    func didSelected() {
        mainView.collectionView.rx
            .modelSelected(ResultModel.self)
            .map { $0.id }
            .subscribe(onNext: {[weak self] id in
                let detailVC = SearchDetailViewController()
                detailVC.viewModel.input.viewDidLoadTrigger.accept(id)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: self.disposeBag)
        self.mainView.collectionView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
     
    }
    
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
    
    func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화를 검색해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
