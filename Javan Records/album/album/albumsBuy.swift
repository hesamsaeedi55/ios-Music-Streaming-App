//
//  albumsBuy.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/27/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit

class albumsBuy: UICollectionViewCell {
    
    var albums: albumList? {
        didSet {
            
            let albumname = albums?.nameid
            nameLebale.text = albumname
            
        }
    }
    
    let nameLebale: UILabel = {
           
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 14)
           return label
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(nameLebale)
               nameLebale.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, paddingtop: 0, paddingleft: 0, paddingbottom: 5, paddingright: 0, width: 0, height: 0)
               nameLebale.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
               print("do this")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
