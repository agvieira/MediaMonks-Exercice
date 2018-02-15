//
//  AlbumViewController.swift
//  MediaMonksExercice
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import RxCocoa
import RxSwift
import SDCAlertView
import UIKit

final class AlbumListViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var activity: UIActivityIndicatorView!
    
    // MARK: Private Variables
    private var viewModel: AlbumViewModelType = AlbumViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.startAnimating()
        self.setupBindTableView()
        self.setupBindError()
        self.setupBindLoading()
        self.setupHandlerTableView()
        viewModel.requestAlbums()
    }
    
    // MARK: Setup Methods
    private func setupBindTableView() {
        self.viewModel.albums.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "AlbumCell",
                                         cellType: UITableViewCell.self)) { (_, album: Album, cell) in
                cell.textLabel?.text = album.title
                cell.textLabel?.numberOfLines = 0
            }.disposed(by: self.disposeBag)
    }
    
    private func setupBindError() {
        self.viewModel.error.asObservable()
            .filter { $0 != nil }
            .subscribe(onNext: { error in
            AlertController.alert(withTitle: error?.title, message: error?.msg, actionTitle: error?.actionsTitles[0])
                self.activity.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
    
    private func setupBindLoading() {
        self.viewModel.loading.asObservable().subscribe(onNext: {[weak self] loading in
            loading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
    
    private func setupHandlerTableView() {
        self.tableView.rx.modelSelected(Album.self).subscribe(onNext: { album in
            let photoList = PhotoListViewController.loadFromStoryboard()
            photoList.prepareForShow(viewModel: PhotoListViewModel(albumId: album.albumId))
            self.navigationController?.pushViewController(photoList, animated: true)
        }).disposed(by: self.disposeBag)
    }
}
