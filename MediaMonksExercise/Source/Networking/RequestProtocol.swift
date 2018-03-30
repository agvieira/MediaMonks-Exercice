//
//  RequestProtocol.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import RxSwift

public protocol RequestProtocol {
    associatedtype Target: TargetType
    func requestArray<Model: Mappable>(_ target: Target) -> Observable<[Model]>
    func requestObject<Model: Mappable>(_ target: Target) -> Observable<Model>
    func requestJSON(_ target: Target) -> Observable<Data>
}

public extension URL {
    
    init<T: TargetType>(target: T) {
        if target.path.isEmpty {
            self = target.baseURL
        } else {
            self = target.baseURL.appendingPathComponent(target.path)
        }
    }
}
