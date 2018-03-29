//
//  DataError.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Mapper

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

extension JSONParseError {
    static internal func fromModelMapper(_ error: MapperError) -> JSONParseError {
        switch error {
        case let .convertibleError(value, type):
            return .convertibleError(value: value, type: type)
        case let .customError(field, message):
            return .customError(field: field, message: message)
        case let .invalidRawValueError(field, value, type):
            return .invalidRawValueError(field: field, value: value, type: type)
        case let .missingFieldError(field):
            return .missingFieldError(field: field)
        case let .typeMismatchError(field, value, type):
            return .typeMismatchError(field: field, value: value, type: type)
        }
    }
}
