//
//  PhotoTableViewCell.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import UIKit
import Kingfisher

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

extension UIImageView {
    
    func loadImage(url: String = "", placeholder: String) {
        if let imageUrl = URL(string: url) {
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: url)
            self.kf.setImage(with: resource,
                             placeholder: UIImage(named: placeholder),
                             options: nil,
                             progressBlock: nil,
                             completionHandler: nil)
        } else {
            self.image = UIImage(named: placeholder)
        }
    }
    
    func loadImage(url: URL?, placeholder: String) {
        if let imageUrl = url {
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: url?.absoluteString)
            self.kf.setImage(with: resource,
                             placeholder: UIImage(named: placeholder),
                             options: nil,
                             progressBlock: nil,
                             completionHandler: nil)
        } else {
            self.image = UIImage(named: placeholder)
        }
    }
    
    func loadImage(url: String = "") {
        guard let imageUrl = URL(string: url) else { return }
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: url)
        self.kf.setImage(with: resource)
    }
}
