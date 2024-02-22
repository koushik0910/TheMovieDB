//
//  Movie.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation

struct Movie: Codable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]?
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let tagline: String?
    let credits: Credits?
    let reviews: Reviews?
    
    var posterFullPath: String {
        "https://image.tmdb.org/t/p/w500" + posterPath
    }
    
    var backdropFullPath: String {
        "https://image.tmdb.org/t/p/w500" + backdropPath
    }
    
    var votingPercentage: String {
        return String(Int(voteAverage * 10)) + "%"
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case runtime
        case tagline
        case credits
        case reviews
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - MovieData
struct MovieData: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}


