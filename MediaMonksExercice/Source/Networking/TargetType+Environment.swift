//
//  TargetType+Environment.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Mapper
import Moya

extension TargetType {
    var environment: Environment {
        guard let envDic = Bundle.main.infoDictionary?["Environment"] as? NSDictionary else {
            fatalError("there isn't environment defined in info.plist")
        }
        guard let envi = Environment.from(envDic) else {
            fatalError("couldn’t be completed parse \(envDic.description) to Environment")
        }
        return envi
    }
}
