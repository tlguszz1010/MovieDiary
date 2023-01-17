//
//  HomeViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import Kingfisher

@frozen enum APIIndex : Int, CaseIterable {
    case popularIdx
    case toprateIdx
    case upcomingIdx
    
    var SectionTitle : String {
        switch self {
        case .popularIdx:
            return "인기있는 영화"
        case .toprateIdx:
            return "평점 높은 영화"
        case .upcomingIdx:
            return "개봉 예정인 영화"
            
        }
    }
    
    static var numberOfRows: Int {
        return Self.allCases.count
    }
}

class HomeViewController: UIViewController {
    let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        mainView.movieCollectionView.delegate = self
        mainView.movieCollectionView.dataSource = self
        mainView.movieCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        mainView.movieCollectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass") , style: .plain, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func searchButtonClicked() {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return APIIndex.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        guard let index = APIIndex(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch index {
        case .popularIdx:
            cell.url = BaseURL.popularURL + APIKey.TMDB
        case .toprateIdx:
            cell.url = BaseURL.topRatedURL + APIKey.TMDB
        case .upcomingIdx:
            cell.url = BaseURL.upcomingURL + APIKey.TMDB
        }
       
        cell.requestAPI()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as? HomeCollectionHeaderView else { return HomeCollectionHeaderView() }
            header.configureHeaderView()
            guard let index = APIIndex(rawValue: indexPath.section) else { return UICollectionViewCell() }
            switch index {
            case .popularIdx:
                header.headerLabel.text = APIIndex(rawValue: indexPath.section)?.SectionTitle
            case .toprateIdx:
                header.headerLabel.text = APIIndex(rawValue: indexPath.section)?.SectionTitle
            case .upcomingIdx:
                header.headerLabel.text = APIIndex(rawValue: indexPath.section)?.SectionTitle
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width / 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}
