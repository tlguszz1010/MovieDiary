//
//  HomeViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import Kingfisher


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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.section == 0 {
            cell.url = BaseURL.popularURL + APIKey.TMDB
        } else if indexPath.section == 1 {
            cell.url = BaseURL.topRatedURL + APIKey.TMDB
           
        } else if indexPath.section == 2 {
            cell.url = BaseURL.upcomingURL + APIKey.TMDB
        }
        cell.test()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as? HomeCollectionHeaderView else { return HomeCollectionHeaderView() }
            header.configureHeaderView()
            if indexPath.section == 0 {
                header.headerLabel.text = "인기있는 영화"
            } else if indexPath.section == 1 {
                header.headerLabel.text = "평점 높은 영화"
            } else if indexPath.section == 2 {
                header.headerLabel.text = "개봉 예정인 영화"
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
