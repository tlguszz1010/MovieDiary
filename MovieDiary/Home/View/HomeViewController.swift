//
//  HomeViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import Kingfisher
import RxSwift

class HomeViewController: UIViewController {
    // MARK: View
    let mainView = HomeView()
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
}

extension HomeViewController {
    func collectionViewConfigure() {
        mainView.movieCollectionView.delegate = self
        mainView.movieCollectionView.dataSource = self
        mainView.movieCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        mainView.movieCollectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier)
    }
    func navigationUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    func configure() {
        collectionViewConfigure()
        navigationUI()
    }
    @objc func searchButtonClicked() {
        let searchVc = SearchViewController()
        self.navigationController?.pushViewController(searchVc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Section이 여러개인 경우는 rx.items보다 RxDataSource로 접근
        return APIIndex.numberOfRows
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cellForItemAt -> 컬렉션뷰의 지정된 위치에 표시할 셀을 요청하는 메서드
        guard let cell = mainView.movieCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        guard let section = APIIndex(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .popularIdx:
            // 지금 뷰가 emit하고 있음 -> 뷰모델이 emit 해서 뷰가 받아야함 -> 뷰모델이 api를 가지고 있어야함 -> 거기서 호출한 데이터를 뷰에 넘겨줌
            // -> 이 과정 자체 필요 x -> viewModel에서 애초에 각각의 섹션에 해당하는 url로 통신을해서 url 데이터를 받은다음, posterList에 넣어준다 -> HomecollectionViewCell(view)에서 넣어줌
            // BaseURL.popularURL + APIKey.TMDB -> 뷰에서 보여줄 데이터 x 이 데이터를 통해 posterPath를 얻음 -> PosterPath가 뷰모델
            
            // View에서 Model(URL)을 ViewModel로 보내고 있네
            // Section을 뷰모델로 보내줌 -> 그에대한 모델값을 뷰모델로부터 받아옴
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
                // sectionTitle은 뷰에서 보여줄 데이터라서 뷰모델에 있어야함
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width / 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}
