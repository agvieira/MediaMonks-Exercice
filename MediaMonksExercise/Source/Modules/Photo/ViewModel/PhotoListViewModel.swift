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
    var error: Variable<GenericError?> { get }
    var loading: Variable<Bool> { get }
    
    func requestPhotos()
}

final class PhotoListViewModel: PhotoListViewModelType {

    // MARK: Public Variables
    var error = Variable<GenericError?>(nil)
    var photos = Variable([Photo]())
    var loading = Variable(false)
    
    // MARK: Private variables
    private var observablePhotos: Observable<[Photo]> = Observable.from(optional: [Photo]())
    private let disposeBag = DisposeBag()
    private typealias Target = PhotoListTargetType
    private var provider: RequestProvider = RequestProvider<Target>()
    private var albumId: Int
    
    init(albumId: Int) {
        self.albumId = albumId
    }
    
    func requestPhotos() {
        self.loading.value = true
        self.observablePhotos = provider.requestArray(Target.getPhotos(albumId: self.albumId))
        self.observablePhotos.subscribe(onNext: {[weak self] photos in
            self?.photos.value = photos
            }, onError: {[weak self] _ in
                self?.error.value = GenericError(title: "Connection Error",
                                                 msg: "There was a problem with our servers\nplease try again later")
            }, onCompleted: {[weak self] in
                self?.loading.value = false
        }).disposed(by: self.disposeBag)
    }
}
