//
//  APIServent.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation

struct APIServent{
    static var baseURL = "https://api.themoviedb.org"
}

enum HTTPMethod: String{
    case get
    case post
    case put
    case delete
    
    var description: String{
        return self.rawValue.uppercased()
    }
}


