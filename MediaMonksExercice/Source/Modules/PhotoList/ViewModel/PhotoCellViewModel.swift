//
//  PhotoCellViewModel.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

protocol PhotoCellViewModelType {
    var photo: Photo? { get }
    var photoUrl: URL? { get }
    var photoTitle: String { get }
}

final class PhotoCellViewModel: PhotoCellViewModelType {
    var photo: Photo?
    var photoUrl: URL? {
        return self.photo?.thumbnailUrl
    }
    var photoTitle: String {
        return self.photo?.title ?? ""
    }
    
    init(photo: Photo) {
        self.photo = photo
    }
}
