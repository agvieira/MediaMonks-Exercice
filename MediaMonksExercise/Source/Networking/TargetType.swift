//
//  TargetType.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 28/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public protocol TargetType {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    
    var parameters: [String: Any]? { get }
    
    var parameterEncoding: ParameterEncoding { get }
}
