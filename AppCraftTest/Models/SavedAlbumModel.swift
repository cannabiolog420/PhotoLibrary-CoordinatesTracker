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
    @objc dynamic var id: Int = 0

    

    convenience init(title: String,id:Int) {
        
        
        self.init()
        self.title = title
        self.id = id
    }
}


