//
//  AlbumViewModel.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import RxSwift

protocol AlbumViewModelType {
    var albums: Variable<[Album]> { get }
    var error: Variable<GenericError?> { get }
    var loading: Variable<Bool> { get }
    
    func requestAlbums()
}

final class AlbumViewModel: AlbumViewModelType {
    
    // MARK: Public Variables
    var error = Variable<GenericError?>(nil)
    var albums = Variable([Album]())
    var loading = Variable(false)
    
    // MARK: Private variables
    private var observableAlbums: Observable<[Album]> = Observable.from([Album]())
    private let disposeBag = DisposeBag()
    private typealias Target = AlbumTargetType
    private var provider: RequestProvider = RequestProvider<Target>()
    
    func requestAlbums() {
        self.loading.value = true
        self.observableAlbums = provider.requestArray(Target.getAlbums)        
        self.observableAlbums.subscribe(onNext: {[weak self] albums in
            self?.albums.value = albums
            }, onError: {[weak self] _ in
                self?.error.value = GenericError(title: "Connection Error",
                                                 msg: "There was a problem with our servers\nplease try again later")
            }, onCompleted: {[weak self] in
                self?.loading.value = false
        }).disposed(by: self.disposeBag)
    }
}
