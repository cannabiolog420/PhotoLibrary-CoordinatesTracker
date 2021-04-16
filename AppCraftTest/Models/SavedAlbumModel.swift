//
//  SavedAlbumModel.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import Foundation
import RealmSwift



class SavedAlbum: Object {
    
    
    @objc dynamic var title: String = ""
    

    convenience init(title: String) {
        
        
        self.init()
        self.title = title
    }
}
