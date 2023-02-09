//
//  BaseURL.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/14.
//

import Foundation

enum BaseURL {
    static let popularURL = "https://api.themoviedb.org/3/movie/popular?api_key="
    static let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    static let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming?api_key="
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
}