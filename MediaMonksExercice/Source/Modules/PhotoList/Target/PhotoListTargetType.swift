//
//  PhotoListTargetType.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Moya

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
    
    var method: Moya.Method {
        switch self {
        case .getPhotos:
            return Moya.Method.get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.default)
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
