//
//  MediaMonksExerciceTests.swift
//  MediaMonksExerciceTests
//
//  Created by Andre Vieira on 14/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import XCTest
import Mapper
@testable import MediaMonksExercise

class MediaMonksExerciseTests: XCTestCase {
    
    var mapper: Mapper!
    var photo: Photo!
    var viewModel: PhotoCellViewModelType!
    
    override func setUp() {
        super.setUp()
        let json = ["albumId": 1,
                    "id": 1,
                    "title": "teste",
                    "url": "http://google.com",
                    "thumbnailUrl": "http://google.com"] as [String : Any]
        mapper = Mapper(JSON: json as NSDictionary)
        photo = try! Photo(map: mapper)
        viewModel = PhotoCellViewModel(photo: photo)
    }
    
    func testGetPhotoUrl() {
        XCTAssertNotNil(viewModel.photoUrl)
        XCTAssertEqual(viewModel.photoUrl?.absoluteString, "http://google.com")
    }
    
    func testGetPhotoTitle() {
        XCTAssertNotNil(viewModel.photoTitle)
        XCTAssertEqual(viewModel.photoTitle, "teste")
    }
    
}
