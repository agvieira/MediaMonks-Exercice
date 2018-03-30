//
//  Mappable.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 29/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

public protocol Mappable {
    init(map: Mapper) throws
}

public extension Mappable {
    public static func from(_ DATA: Data) throws -> Self? {
        do {
            let jsonObjc = try Self.mapToJSON(data: DATA)
            guard let JSON = jsonObjc as? NSDictionary else {
                throw JSONParseError.invalid(DATA)
            }
            return try? self.init(map: Mapper(JSON: JSON))
        } catch {
            throw error
        }
    }
    
    public static func from(_ JSON: NSDictionary) -> Self? {
        return try? self.init(map: Mapper(JSON: JSON))
    }
    
    public static func from(_ DATA: Data) throws -> [Self]? {
        do {
            let jsonObjc = try Self.mapToJSON(data: DATA)
            if let array = jsonObjc as? [NSDictionary] {
                return try? array.map { try self.init(map: Mapper(JSON: $0)) }
            }
        } catch {
            throw error
        }
        
        return nil
    }
    
    public static func mapToJSON(data: Data) throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            throw error
        }
    }
}

