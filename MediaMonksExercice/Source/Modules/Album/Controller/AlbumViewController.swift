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
    
    @IBOutlet weak private var tableView: UITableView!
    private var viewModel: AlbumViewModelType = AlbumViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindTableView()
        self.setupBindError()
        self.setupHandlerTableView()
        viewModel.requestAlbums()
    }
    
    private func setupBindTableView() {
        viewModel.albums.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "AlbumCell",
                                         cellType: UITableViewCell.self)) { (_, album: Album, cell) in
                cell.textLabel?.text = album.title
                cell.textLabel?.numberOfLines = 0
            }.disposed(by: self.disposeBag)
    }
    
    private func setupBindError() {
        viewModel.error.asObservable()
            .filter { $0 != nil }
            .subscribe(onNext: { error in
            AlertController.alert(withTitle: error?.title, message: error?.msg, actionTitle: error?.actionsTitles[0])
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
