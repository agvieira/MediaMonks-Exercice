//
//  AlbumTargetType.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Moya

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
    
    var method: Moya.Method {
        switch self {
        case .getAlbums:
            return Moya.Method.get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
