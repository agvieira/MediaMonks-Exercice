//
//  DataError.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

public enum DataError: Swift.Error {
    case jsonParse(JSONParseError, Any)
    case statusCode(NSErrorDomain)
    case underlying(Swift.Error)
    case generic(message: String)
}

public enum JSONParseError: Swift.Error {
    case invalid(Any)
    case convertibleError(value: Any?, type: Any.Type)
    case customError(field: String?, message: String)
    case invalidRawValueError(field: String, value: Any, type: Any.Type)
    case missingFieldError(field: String)
    case typeMismatchError(field: String, value: Any, type: Any.Type)
}

