//
//  Review.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 21/02/24.
//

import Foundation


// MARK: - Result
struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let results: [Review]
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username: String
    let avatarPath: String?
    let rating: Double?
    var fullAvatarPath: String? {
        guard let avatarPath else { return nil }
        return "https://image.tmdb.org/t/p/w500" + avatarPath
    }

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
