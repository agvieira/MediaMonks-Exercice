//
//  ViewController.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class PhotoListViewController: UIViewController, StoryboardLoadable {
    static var storyboardName: String = "Photo"
    
    @IBOutlet weak private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private var viewModel: PhotoListViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        self.setupBindTableView()
        self.setupBindError()
        self.setupHandlerTableView()
        self.viewModel?.requestPhotos()
    }
    
    func prepareForShow(viewModel: PhotoListViewModelType) {
        self.viewModel = viewModel
    }
    
    private func setupBindTableView() {
        self.viewModel?.photos.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "PhotoTableViewCell",
                                         cellType: PhotoTableViewCell.self)) { (_, photo: Photo, cell) in
                                            cell.setupCell(viewModel: PhotoCellViewModel(photo: photo))
            }.disposed(by: self.disposeBag)
    }
    
    private func setupBindError() {
        self.viewModel?.error.asObservable().subscribe(onNext: { error in
            print(error)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupHandlerTableView() {
        self.tableView.rx.modelSelected(Photo.self).subscribe(onNext: { photo in
            let photoDetail = PhotoDetailViewController.loadFromStoryboard()
            photoDetail.prepareForShow(viewModel: PhotoDetailViewModel(photo: photo))
            self.navigationController?.pushViewController(photoDetail, animated: true)
        }).disposed(by: self.disposeBag)
    }
}
