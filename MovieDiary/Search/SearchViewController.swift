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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SearchBar()
    }
    
    
    func SearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화를 검색해주세요"
        searchController.searchBar.rx.text
            .subscribe(onNext: {[weak self] _ in
                self!.viewModel.input.searchTrigger.onNext(searchController.searchBar.text!)
            })
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
}


