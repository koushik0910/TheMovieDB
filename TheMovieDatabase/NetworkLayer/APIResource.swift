//
//  APIResource.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation

protocol APIResource {
    var httpMethod: HTTPMethod { get }
    var methodPath: String { get }
    var params: [String: String]? { get }
}

extension APIResource {
    var urlRequest: URLRequest {
        var urlComponent = URLComponents(string: APIServent.baseURL)!
        urlComponent.path = methodPath
        urlComponent.queryItems = params?.compactMap {
           URLQueryItem(name: $0.0, value: $0.1 )
        }
        
        var request = URLRequest(url: urlComponent.url!)
        
        //HTTP METHOD
        request.httpMethod = httpMethod.description
        
        return request
    }
}
