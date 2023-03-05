//
//  HomeViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import Kingfisher
import RxSwift

final class HomeViewController: UIViewController {
    // MARK: View
    private let mainView = HomeView()
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension HomeViewController {
    private func collectionViewConfigure() {
        mainView.movieCollectionView.delegate = self
        mainView.movieCollectionView.dataSource = self
        mainView.movieCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        mainView.movieCollectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier)
    }
    private func navigationUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    private func configure() {
        collectionViewConfigure()
        navigationUI()
    }
    @objc func searchButtonClicked() {
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return APIIndex.numberOfRows
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        guard let section = APIIndex(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .popularIdx:
            cell.viewModel.input.initTrigger.onNext(indexPath.section)
        case .toprateIdx:
            cell.viewModel.input.initTrigger.onNext(indexPath.section)
        case .upcomingIdx:
            cell.viewModel.input.initTrigger.onNext(indexPath.section)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as? HomeCollectionHeaderView else { return HomeCollectionHeaderView() }
            header.configureHeaderView()
            guard let index = APIIndex(rawValue: indexPath.section) else { return UICollectionViewCell() }
            switch index {
            case .popularIdx:
                header.headerLabel.text = APIIndex(rawValue: indexPath.section)?.sectionTitle
            case .toprateIdx:
                header.headerLabel.text = APIIndex(rawValue: indexPath.section)?.sectionTitle
            case .upcomingIdx:
                header.headerLabel.text = APIIndex(rawValue: indexPath.section)?.sectionTitle
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}
