//
//  Response+MapModel.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

public extension Data {
    func mapModel<Model: Mappable>() throws -> Model {
        return try self.mapModel(json: self.mapToJSON())
    }
    
    func mapModel<Model: Mappable>() throws -> [Model] {
        let json = try self.mapToJSON()
        guard let jsonArray = json as? NSArray else {
            throw DataError.jsonParse(.invalid(json), self)
        }
        return try Array(jsonArray).map(self.mapModel)
    }
    
    private func mapToJSON() throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self, options: [])
        } catch {
            throw DataError.underlying(error)
        }
    }
    
    private func mapModel<Model: Mappable>(json: Any) throws -> Model {
        guard let jsonDictionary = json as? NSDictionary else {
            throw DataError.jsonParse(.invalid(json), self)
        }
        
        do {
            let json = try Model(map: Mapper(JSON: jsonDictionary))
            return json
        } catch {
            throw DataError.underlying(error)
        }
    }
}
