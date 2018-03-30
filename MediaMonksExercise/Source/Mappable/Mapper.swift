//
//  Mapper.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 29/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

public protocol PrimitiveType {
    associatedtype PrimitiveType = Self
    
    static func fromMap(_ value: Any) throws -> PrimitiveType
}

public extension PrimitiveType {
    public static func fromMap(_ value: Any) throws -> PrimitiveType {
        if let object = value as? PrimitiveType {
            return object
        }
        
        throw JSONParseError.convertibleError(value: value, type: PrimitiveType.self)
    }
}

extension NSDictionary: PrimitiveType {}
extension NSArray: PrimitiveType {}

extension String: PrimitiveType {}
extension Int: PrimitiveType {}
extension Int32: PrimitiveType {}
extension Int64: PrimitiveType {}
extension UInt: PrimitiveType {}
extension UInt32: PrimitiveType {}
extension UInt64: PrimitiveType {}
extension Float: PrimitiveType {}
extension Double: PrimitiveType {}
extension Bool: PrimitiveType {}

public struct Mapper {
    private let JSON: NSDictionary
    
    public init(JSON: NSDictionary) {
        self.JSON = JSON
    }
    
    public func from<T: PrimitiveType>(_ field: String) throws -> T where T == T.PrimitiveType {
        return try T.fromMap(try self.JSONFromField(field))
    }
    
    public func from<T: PrimitiveType>(_ field: String) throws -> [T] where T == T.PrimitiveType {
        let value = try self.JSONFromField(field)
        if let JSON = value as? [Any] {
            return try JSON.map(T.fromMap)
        }
        
        throw JSONParseError.typeMismatchError(field: field, value: value, type: T.self)
    }
    
    public func from<T: Mappable>(_ field: String) throws -> T {
        let value = try self.JSONFromField(field)
        if let JSON = value as? NSDictionary {
            return try T(map: Mapper(JSON: JSON))
        }
        
        throw JSONParseError.typeMismatchError(field: field, value: value, type: T.self)
    }
    
    public func from<T: Mappable>(_ field: String) throws -> [T] {
        let value = try self.JSONFromField(field)
        if let JSON = value as? [NSDictionary] {
            return try JSON.map { try T(map: Mapper(JSON: $0)) }
        }
        
        throw JSONParseError.typeMismatchError(field: field, value: value, type: T.self)
    }
    
    private func JSONFromField(_ field: String) throws -> Any {
        if let value = field.isEmpty ? self.JSON : self.JSON.safeValue(forKeyPath: field) {
            return value
        }
        
        throw JSONParseError.missingFieldError(field: field)
    }
}

extension NSDictionary {
    @nonobjc
    func safeValue(forKeyPath keyPath: String) -> Any? {
        var object: Any? = self
        var keys = keyPath.split(separator: ".").map(String.init)
        
        while !keys.isEmpty, let currentObject = object {
            let key = keys.remove(at: 0)
            object = (currentObject as? NSDictionary)?[key]
        }
        
        return object
    }
}
