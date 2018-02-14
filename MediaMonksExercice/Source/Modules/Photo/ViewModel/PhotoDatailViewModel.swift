//
//  PhotoDatailViewModel.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation

protocol PhotoDetailViewModelType {
    var photo: Photo? { get }
    var photoUrl: URL? { get }
    var photoTitle: String { get }
    var albumDesc: String { get }
}

final class PhotoDetailViewModel: PhotoDetailViewModelType {
    
    var photo: Photo?
    var photoUrl: URL? {
        return self.photo?.thumbnailUrl
    }
    var photoTitle: String {
        return self.photo?.title ?? ""
    }
    var albumDesc: String {
        guard let albumId = self.photo?.albumId else {
            return ""
        }
        return "album id \(albumId)"
    }
    
    init(photo: Photo) {
        self.photo = photo
    }
}
