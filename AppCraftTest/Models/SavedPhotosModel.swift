//
//  SavedPhotosModel.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import Foundation
import RealmSwift




class SavedAlbumPhotos: Object {


    @objc dynamic var imageData:Data?



    convenience init(imageData:Data) {


        self.init()
        self.imageData = imageData

    }
}
