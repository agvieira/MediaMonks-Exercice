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

final class PhotoListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private var viewModel: PhotoListViewModelType = PhotoListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        self.setupBindTableView()
        self.setupBindError()
        self.setupHandlerTableView()
        viewModel.requestPhotos()
    }
    
    private func setupBindTableView() {
        viewModel.photos.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "PhotoTableViewCell",
                                         cellType: PhotoTableViewCell.self)) { (_, photo: Photo, cell) in
                                            cell.setupCell(viewModel: PhotoCellViewModel(photo: photo))
            }.disposed(by: self.disposeBag)
    }
    
    private func setupBindError() {
        viewModel.error.asObservable().subscribe(onNext: { error in
            print(error)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupHandlerTableView() {
        self.tableView.rx.modelSelected(Photo.self).subscribe(onNext: { photo in
            print(photo.title)
        }).disposed(by: self.disposeBag)
    }
}
