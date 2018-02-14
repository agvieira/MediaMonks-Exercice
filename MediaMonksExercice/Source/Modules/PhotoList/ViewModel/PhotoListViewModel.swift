//
//  PhotoListViewModel.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotoListViewModelType {
    var photos: Variable<[Photo]> { get }
    var error: Variable<String> { get }
    
    func requestPhotos()
}

final class PhotoListViewModel: PhotoListViewModelType {

    // MARK: Public Variables
    var error = Variable("")
    var photos = Variable([Photo]())
    
    // MARK: Private variables
    private var observablePhotos: Observable<[Photo]> = Observable.from([Photo]())
    private let disposeBag = DisposeBag()
    private typealias Target = PhotoListTargetType
    private var provider: RequestProvider = RequestProvider<Target>()
    
    func requestPhotos() {
        self.observablePhotos = provider.requestArray(Target.getPhotos(albumId: 1))
        self.observablePhotos.subscribe(onNext: {[weak self] photos in
            self?.photos.value = photos
            }, onError: {[weak self] _ in
                self?.error.value = "There was a problem with our servers\nplease try again later"
        }).disposed(by: self.disposeBag)
    }
}
