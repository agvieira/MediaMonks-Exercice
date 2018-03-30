//
//  Owner.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 29/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

struct Owner: Mappable {
    var id: Int
    var login: String
    var htmlUrl: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try login = map.from("login")
        try htmlUrl = map.from("html_url")
    }
}
