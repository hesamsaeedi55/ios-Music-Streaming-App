//
//  searchcell.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/29/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase


class searchcell: UITableViewCell {
    
    
    
    var band :Band? {
        
        didSet {
            
            
            let name = band?.name

            self.textLabel?.text = name
            img.loadImage(with: (band?.proImgUrl)!)
            
            who()
            
        }
        
    }
    

    lazy var img : CustomImageView = {
        let photo = CustomImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.backgroundColor = .black
        photo.layer.cornerRadius = 10
        return photo
    }()
    
    
    lazy var followbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("loading", for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        button.addTarget(self, action: #selector(followTappedButton), for: .touchUpInside)
        return button
    }()
    
    
    
    
    func who() {
        
        band?.checkIfBandIsFollowed(completion: { (followed) in
            if followed {
                self.followbutton.setTitle("following", for: .normal)
            }else{
                self.followbutton.setTitle("follow", for: .normal)
            }
        })
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        
      
        self.selectionStyle = .none
        
        
    }

    

    override func layoutSubviews() {
        //super.layoutsubviews hatman bayad neveshte shavad
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 68, y: textLabel!.frame.origin.y - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        
        addSubview(followbutton)
        followbutton.anchor(top: nil, left: nil , bottom: nil, right: rightAnchor, paddingtop: 0, paddingleft: 0, paddingbottom: 0, paddingright: 12, width: 90, height: 30)
        
        addSubview(img)
        img.anchor(top: nil , left: leftAnchor, bottom: nil, right: nil , paddingtop: 5, paddingleft: 5, paddingbottom: 5, paddingright: 0, width: 50, height: 50)
        img.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        followbutton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        followbutton.layer.cornerRadius = 5
        
        
    }
    
    @objc func followTappedButton() {
        
        guard let bandnames = band?.name else {return}
             guard let currentUid = Auth.auth().currentUser?.uid else {return}

           
             if followbutton.titleLabel?.text == "follow" {
                 self.followbutton.setTitle("following", for: .normal)
                 Database.database().reference().child("bandfollowers").child(bandnames).updateChildValues([currentUid : 1])
                 Database.database().reference().child("bandfollowings").child(currentUid).updateChildValues([bandnames : 1])
                 print("follow")
             }else{
                 self.followbutton.setTitle("follow", for: .normal)
                 Database.database().reference().child("bandfollowers").child(bandnames).child(currentUid).removeValue()
                 Database.database().reference().child("bandfollowings").child(currentUid).child(bandnames).removeValue()
                 print("unfollow")
             }
             
             
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
