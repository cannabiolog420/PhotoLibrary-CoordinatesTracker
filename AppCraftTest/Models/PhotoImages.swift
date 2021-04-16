//
//  PhotoImages.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import UIKit



class PhotoImages{
    
    
    var images = [UIImage]()
    var fullImages = [UIImage]()
    
    init(photoModel:[Photo]) {
        
        
        for i in photoModel{
            
            
        AlamofireFetcherService.fetchImage(from: i.thumbnailUrl) { (image) in
            self.images.append(image)
        }
        AlamofireFetcherService.fetchImage(from: i.url) { (image) in
            self.fullImages.append(image)
        }

    }

    
    
    
}
}
