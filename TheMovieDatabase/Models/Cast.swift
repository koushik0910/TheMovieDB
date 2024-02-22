//
//  Credits.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 19/02/24.
//

import Foundation

// MARK: - Cast
struct Cast: Codable {
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let profilePath: String?
    let character: String?
    var fullProfilePath: String? {
        guard let profileImagePath = profilePath else { return nil }
        return "https://image.tmdb.org/t/p/w500" + profileImagePath
    }

    enum CodingKeys: String, CodingKey {
        case gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
        case character
    }
}

// MARK: - Credits
struct Credits: Codable {
    let cast: [Cast]
}

