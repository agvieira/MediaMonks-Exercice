//
//  ParameterEncoding.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 28/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

extension NSNumber {
    func isBool() -> Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

public protocol ParameterEncoding {
    func encode(request: URLRequest?, parameters: [String: Any]?) throws -> URLRequest
}

public struct URLEncoding: ParameterEncoding {
    public static var `default`: URLEncoding { return URLEncoding() }
    
    public func encode(request: URLRequest?, parameters: [String: Any]?) throws -> URLRequest {
        guard var urlRequest = request, let url = urlRequest.url else {
            throw DataError.generic(message: "url request undefined")
        }
        
        guard let parameters = parameters,
            let httpMethod = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET"),
            (httpMethod == .get || httpMethod == .delete || httpMethod == .head),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return urlRequest }
        
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += parseParameter(fromKey: key, value: value)
        }
        
        urlComponents.percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") +
            components.map { "\($0)=\($1)" }.joined(separator: "&")
        
        urlRequest.url = urlComponents.url
        
        return urlRequest
    }
    
    public func parseParameter(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += parseParameter(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += parseParameter(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool() {
                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    public func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        guard let escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else { return "" }
        return escaped
    }
}

public struct JSONEncoding: ParameterEncoding {

    public static var `default`: JSONEncoding { return JSONEncoding() }

    public func encode(request: URLRequest?, parameters: [String: Any]?) throws -> URLRequest {
        guard var urlRequest = request else {
            throw DataError.generic(message: "url request undefined")
        }
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
        } catch {
            throw error
        }
        return urlRequest
    }
}
