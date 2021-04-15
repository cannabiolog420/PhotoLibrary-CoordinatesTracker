//
//  Photo.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 15.04.2021.
//

import UIKit

typealias Photos = [Photo]

struct Photo: Codable {
    
    let url: String
    let thumbnailUrl: String
//    let imagePreviewData:Data
//        
//
//            init?(dict:[String:Any]){
//                
//                guard let url = dict["url"] as? String,
//                      let thumbnailUrl = dict["thumbnailUrl"] as? String else { return nil}
//                self.url = url
//                self.thumbnailUrl = thumbnailUrl
//            
//                
//            }
//        
//        static func getArray(from jsonArray:Any)->Photos?{
//            
//            guard let array = jsonArray as? Array<[String:Any]> else { return nil }
//
//            return array.compactMap { Photo(dict: $0) }
//        }
    }


//DispatchQueue.global().async {
//    guard let imageUrl = URL(string: photo.thumbnailUrl) else { return }
//    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//
//    DispatchQueue.main.async {
//        self.photoImageView.image = UIImage(data: imageData)
//    }
//}
