//
//  PhotoListTargetType.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

enum PhotoListTargetType {
    case getPhotos(albumId: Int)
}

extension PhotoListTargetType: TargetType {
    var headers: [String: String]? { return nil }
    
    var baseURL: URL {
        return URL(string: self.environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPhotos(let albumId):
            return ["albumId": albumId]
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
