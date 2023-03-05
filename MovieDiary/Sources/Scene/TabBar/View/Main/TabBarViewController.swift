//
//  TabBarViewController.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    // MARK: - 각 tab bar의 인스턴스 생성
    private let homeVC = HomeViewController()
    private let bookMarkVC = BookMarkViewController()
    private let calendarVC = CalendarViewController()
    
    // 홈, 즐겨찾기, 캘린더
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarUI()
    }
    
    private func tabBarUI() {
        // MARK: - tab bar 백그라운드 색상
        tabBar.tintColor = .lightGray
       
        // MARK: - 각 tab bar의 Title 설정
        homeVC.title = "홈"
        bookMarkVC.title = "즐겨찾기"
        calendarVC.title = "기록날짜"
        
        // MARK: - 각 tab bar의 Image 설정
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        bookMarkVC.tabBarItem.image = UIImage(systemName: "star.fill")
        calendarVC.tabBarItem.image = UIImage(systemName: "calendar")
        
        // MARK: - Title Text를 항상 크게 보이게 설정
//        homeVC.navigationItem.largeTitleDisplayMode = .always
//        bookMarkVC.navigationItem.largeTitleDisplayMode = .always
//        calendarVC.navigationItem.largeTitleDisplayMode = .always
        
        // MARK: - tab bar의 네비게이션 설정
        setTabBarNavi()
    }
    
    private func setTabBarNavi() {
        let homeNavi = UINavigationController(rootViewController: homeVC)
        let bookMarkNavi = UINavigationController(rootViewController: bookMarkVC)
        let calendarNavi = UINavigationController(rootViewController: calendarVC)
        
//        homeNavi.navigationBar.prefersLargeTitles = true
//        bookMarkNavi.navigationBar.prefersLargeTitles = true
//        calendarNavi.navigationBar.prefersLargeTitles = true
        
        // MARK: - 탭바 컨트롤러에 각각의 tab 넣기
        setViewControllers([homeNavi, bookMarkNavi, calendarNavi], animated: false)
    }
    
    
    
}
