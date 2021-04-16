//
//  AlbumCell.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 14.04.2021.
//

import UIKit




class AlbumCell: UITableViewCell {
    
    // Properties
    
    static let identifier = "albumCell"
    let albumTitleLabel = UILabel()
    
    
    // Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // Methods
    func set(with album:Album){
        
        albumTitleLabel.text = album.title
        
    }
    
    func set(with savedAlbum:SavedAlbum){
        
        albumTitleLabel.text = savedAlbum.title
        
    }
    
    
    
    // UI Setup
    
    private func setupTitleLabel(){
        
        addSubview(albumTitleLabel)
        setTitleLabelConstraints()
    }
    
    private func setTitleLabelConstraints(){
        
        
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        

        albumTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        albumTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30).isActive = true
    
    }
}
