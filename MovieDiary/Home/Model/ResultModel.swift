//
//  Model.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/01/18.
//

import Foundation

struct ResultModel: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}