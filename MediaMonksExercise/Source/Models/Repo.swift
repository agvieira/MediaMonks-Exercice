//
//  Repo.swift
//  MediaMonksExercise
//
//  Created by Andre Germiniani on 29/03/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation


struct Repo: Mappable {
    var id: Int
    var name: String
    var fullName: String
    var owner: Owner
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try fullName = map.from("full_name")
        try owner = map.from("owner")
    }
}
