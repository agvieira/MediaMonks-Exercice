//
//  PhotoTableViewCell.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import UIKit

protocol PhotoTableViewCellType {
    func setupCell(viewModel: PhotoCellViewModelType)
}

final class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak private var photo: UIImageView!
    @IBOutlet weak private var title: UILabel!
    
    private var viewModel: PhotoCellViewModelType?
    
    func setupCell(viewModel: PhotoCellViewModelType) {
        self.viewModel = viewModel
        self.setupPhoto()
        self.setupTitle()
    }
    
    private func setupTitle() {
        self.title.text = self.viewModel?.photoTitle
    }
    
    private func setupPhoto() {
        self.photo.loadImage(url: self.viewModel?.photoUrl, placeholder: "ic_picture")
    }
}
