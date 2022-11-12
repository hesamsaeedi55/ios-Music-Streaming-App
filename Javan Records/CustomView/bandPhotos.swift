//
//  CollectionViewCell.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/27/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit

class bandPhotos: UICollectionViewCell {
    
    let photoImageView:UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.backgroundColor = .gray
        return photo
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingtop: 20, paddingleft: 20, paddingbottom: 20, paddingright: 20, width: 0, height: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
