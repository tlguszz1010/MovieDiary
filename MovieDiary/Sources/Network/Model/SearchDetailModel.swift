//
//  SearchDetailModel.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/15.
//

import Foundation

struct ResponseDetailData: Codable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.budget = try container.decode(Int.self, forKey: .budget)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.homepage = try container.decode(String.self, forKey: .homepage)
        self.id = try container.decode(Int.self, forKey: .id)
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.productionCompanies = try container.decode([ProductionCompany].self, forKey: .productionCompanies)
        self.productionCountries = try container.decode([ProductionCountry].self, forKey: .productionCountries)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.revenue = try container.decode(Int.self, forKey: .revenue)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.spokenLanguages = try container.decode([SpokenLanguage].self, forKey: .spokenLanguages)
        self.status = try container.decode(String.self, forKey: .status)
        self.tagline = try container.decode(String.self, forKey: .tagline)
        self.title = try container.decode(String.self, forKey: .title)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.logoPath = (try? container.decode(String.self, forKey: .logoPath)) ?? "없음"
        self.name = try container.decode(String.self, forKey: .name)
        self.originCountry = (try? container.decode(String.self, forKey: .originCountry)) ?? "없음"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.iso3166_1 = try container.decode(String.self, forKey: .iso3166_1)
        self.name = try container.decode(String.self, forKey: .name)
    }
}


// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.iso639_1 = try container.decode(String.self, forKey: .iso639_1)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
