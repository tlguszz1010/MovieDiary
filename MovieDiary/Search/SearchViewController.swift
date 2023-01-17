//
//  SearchViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit

class SearchViewController: UIViewController {
    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SearchBar()
    }
    
    
    func SearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화를 검색해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
}


