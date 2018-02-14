//
//  PhotoDetailViewController.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak private var photo: UIImageView!
    @IBOutlet weak private var albumId: UILabel!
    @IBOutlet weak private var photoTitle: UILabel!
    
    private var viewModel: PhotoDetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitle()
        self.setupPhoto()
        self.setupAlbumId()
    }
    
    func prepareForShow(viewModel: PhotoDetailViewModelType) {
        self.viewModel = viewModel
    }
    
    private func setupTitle() {
        self.photoTitle.text = self.viewModel?.photoTitle
    }
    
    private func setupPhoto() {
        self.photo.loadImage(url: self.viewModel?.photoUrl, placeholder: "ic_picture")
    }
    
    private func setupAlbumId() {
        self.albumId.text = self.viewModel?.albumDesc
    }
}
