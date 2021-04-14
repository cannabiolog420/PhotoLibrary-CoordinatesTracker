//
//  AlbumCell.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 14.04.2021.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    static let identifier = "albumCell"
    
    let albumTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(albumTitleLabel)
        
        setupTitleLabel()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupTitleLabel(){
        
        albumTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setTitleLabelConstraints(){
        
        
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        albumTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16).isActive = true
        albumTitleLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        albumTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 16).isActive = true
    }
}
