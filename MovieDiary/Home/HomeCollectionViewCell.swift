//
//  HomeCollectionViewCell.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    let api = APIService()
    var posterList : [String] = []
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      
        let layout = HomeInsideFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        self.backgroundColor = .systemPink
        collectionView.register(HomeInsideCollectionViewCell.self, forCellWithReuseIdentifier: HomeInsideCollectionViewCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        api.getMostPopular { [weak self] json in
            for items in json["results"].arrayValue {
                self?.posterList.append(items["poster_path"].stringValue)
                print(self!.posterList)
                print("📮📮📮")
                print(self?.posterList.count)
            }
            collectionView.reloadData()
        }
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HomeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeInsideCollectionViewCell.identifier, for: indexPath) as! HomeInsideCollectionViewCell
        cell.image.kf.setImage(with: URL(string: BaseURL.baseImageURL + posterList[indexPath.row]))
        return cell
    }
    
}

extension HomeCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.size.width / 3, height: 200)
    }
}
