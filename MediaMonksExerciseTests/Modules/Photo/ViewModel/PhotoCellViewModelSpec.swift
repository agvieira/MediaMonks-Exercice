//
//  PhotoCellViewModelSpec.swift
//  MediaMonksExerciseTests
//
//  Created by Andre Vieira on 15/02/18.
//  Copyright © 2018 Andre Vieira. All rights reserved.
//

import Foundation
import Mapper
import Nimble
import Quick

@testable import MediaMonksExercise

class PhotoCellViewModelSpec: QuickSpec {
    
    var mapper: Mapper!
    var photo: Photo!
    var viewModel: PhotoCellViewModelType!
    let json = ["albumId": 1,
                "id": 1,
                "title": "title",
                "url": "http://google.com",
                "thumbnailUrl": "http://google.com"] as [String : Any]
    
    override func spec() {
        describe("Unit test PhotoCellViewModel") {
            beforeEach {
                self.mapper = Mapper(JSON: self.json as NSDictionary)
                self.photo = try! Photo(map: self.mapper)
                self.viewModel = PhotoCellViewModel(photo: self.photo)
            }
            
            it("has photo url", closure: {
                expect(self.viewModel.photoUrl).toNot(beNil())
                expect(self.viewModel.photoUrl?.absoluteString).to(equal("http://google.com"))
            })
            
            it("has photo title", closure: {
                expect(self.viewModel.photoTitle).toNot(beNil())
                expect(self.viewModel.photoTitle).to(equal("title"))
            })
        }
    }
}
