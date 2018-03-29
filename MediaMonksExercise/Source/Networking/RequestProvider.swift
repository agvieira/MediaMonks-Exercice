//
//  RequestProvider.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Mapper
import RxSwift

final class RequestProvider<Target: TargetType>: RequestProtocol {
    private let endpoint: ((_ target: Target) -> URLRequest)
    
    public init() {
        endpoint = { (target: Target) -> URLRequest in
            let request = URLRequest(url: URL(target: target))
            return request
        }
    }
    
    func requestArray<Model: Mappable>(_ target: Target) -> Observable<[Model]> {
        return self.doRequest(target).flatMap({ response -> Observable<[Model]> in
            return Observable.just(try response.data.mapModel())
        })
    }
    
    func requestObject<Model: Mappable>(_ target: Target) -> Observable<Model> {
        return self.doRequest(target).flatMap({ response -> Observable<Model> in
            return Observable.just(try response.data.mapModel())
        })
    }
    
    func requestJSON(_ target: Target) -> Observable<Data> {
        return self.doRequest(target).flatMap({ response -> Observable<Data> in
            return Observable.just(response.data)
        })
    }
    
    private func doRequest(_ target: Target) -> Observable<(response: URLResponse, data: Data)> {
        let session = URLSession.shared
        return Observable.create { observer in
            var request = self.endpoint(target)
            request.httpMethod = target.method.rawValue
            do {
                request = try target.parameterEncoding.encode(request: request, parameters: target.parameters)
                
                session.dataTask(with: request, completionHandler: { data, response, error in
                    if let error = error {
                        observer.onError(error)
                        observer.onCompleted()
                    }
                    
                    if let response = response, let data = data {
                        observer.onNext((response: response, data: data))
                        observer.onCompleted()
                    }
                }).resume()
            } catch {
                observer.onError(error)
                observer.onCompleted()
            }
            
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
