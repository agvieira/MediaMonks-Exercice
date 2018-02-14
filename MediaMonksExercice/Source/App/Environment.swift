//
//  Environment.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Mapper

struct Environment: Mappable {
    var baseUrl: String
    
    init(map: Mapper) throws {
        try baseUrl = map.from("baseUrl")
    }
}
