//
//  PhotoCell.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 15.04.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    
    // Properties
    
    static let identifier = "photoCell"
    var photoImageView = UIImageView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func set(with photo:Photo){
        
        AlamofireFetcherService.fetchImage(from: photo.thumbnailUrl) { (image) in
                self.photoImageView.image = image
        }
    }
    

    


// MARK: - UI Setup

    private func setupPhotoImageView() {
        
        
        addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.pin(to: contentView)
}
    
    
    
    
}
