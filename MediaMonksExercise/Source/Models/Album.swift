//
//  Album.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

struct Album: Mappable {
    var userId: Int
    var albumId: Int
    var title: String
    
    init(map: Mapper) throws {
        try userId = map.from("userId")
        try albumId = map.from("id")
        try title = map.from("title")
    }
}
