//
//  albumVC.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/6/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit


class albumVC: UICollectionViewCell {
    
    var albumImg : String?

    
    var albums:albumList? {
        didSet{
            
            let albumname = albums?.nameid
            nameLebale.text = albumname
            
            let albumlinkImg = albums?.linkid
            
            albumImage.loadImage(with: albumlinkImg!)
            
            profileVC().albumImg = albumlinkImg
            
            print("sth")
           
        }
            
            
        }
    
    let albumImage: CustomImageView = {
        let photo = CustomImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.backgroundColor = .black
        photo.layer.cornerRadius = 10
        return photo
    }()
    
 
    
    let nameLebale: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(nameLebale)
        nameLebale.anchor(top: nil, left: self.leftAnchor, bottom: bottomAnchor, right: nil, paddingtop: 0, paddingleft: 10, paddingbottom: 5, paddingright: 0, width: 0, height: 0)
        nameLebale.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addSubview(albumImage)
        albumImage.anchor(top: topAnchor, left: self.leftAnchor, bottom: nameLebale.topAnchor, right: rightAnchor, paddingtop: 0, paddingleft: 7, paddingbottom: 0, paddingright: 7, width: 0, height: 0)
        
       
        
        
//        layer.cornerRadius = 12
//        backgroundColor = .gray
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
