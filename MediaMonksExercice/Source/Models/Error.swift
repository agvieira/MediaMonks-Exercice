//
//  Error.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import SDCAlertView

struct GenericError {
    var title: String
    var msg: String
    var actionsTitles: [String]
    var actions: [AlertAction]?
    
    init(title: String,
         msg: String,
         actionsTitles: [String] = ["OK"],
         actions: [AlertAction] = []) {
        self.title = title
        self.msg = msg
        self.actions = actions
        self.actionsTitles = actionsTitles
    }
}
