//
//  AlbumTargetType.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

enum AlbumTargetType {
    case getAlbums
}

extension AlbumTargetType: TargetType {
    
    var headers: [String: String]? { return nil }
    
    var baseURL: URL {
        return URL(string: self.environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getAlbums:
            return "albums"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAlbums:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAlbums:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
