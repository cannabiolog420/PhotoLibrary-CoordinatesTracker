//
//  RealmDBManager.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import Foundation
import RealmSwift




let realm = try! Realm()


class RealmDBManager{
    
    
    static func saveObject(_ album:SavedAlbum ){
        
        try! realm.write{
            
            realm.add(album)
        }
    }
    
    static func deleteObject(_ album:SavedAlbum){
        
        try! realm.write{
            
            realm.delete(album)
        }
    }
    
}
