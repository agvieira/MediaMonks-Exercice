//
//  TestTargetType.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 29/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

enum TestTargetType: TargetType {
    case test
}

extension TestTargetType {
    var headers: [String: String]? { return nil }
    
    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    var path: String {
        switch self {
        case .test:
            return "users/xing/repos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .test:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .test:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
