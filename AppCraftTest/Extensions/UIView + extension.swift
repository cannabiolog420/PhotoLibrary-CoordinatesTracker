//
//  UIView + extension.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 14.04.2021.
//

import UIKit

extension UIView{
    
    func pin(to superView:UIView){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        
    }
}

