//
//  profileHeader.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/6/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase


class profileHeader: UICollectionViewCell {
    
    var delegate : alert!

    var user:User?
    var numberOfFollowers: Int?
    var band:Band? {
        didSet {
            
            configureFollowProfileButton()
            let description = band?.description

            let bandname = band?.name
            
            nameLebale.text = bandname
            descriptionText.text = description
            
            guard  let adminUid = band?.admin else {return}

            
            
            guard let coverImageUrl = band?.imgUrl else {return}
            guard let profileImageUrl = band?.proImgUrl else {return}
            print(profileImageUrl)
            coverImg.loadImage(with: coverImageUrl)
            
            
            
            profileImageView.loadImage(with: profileImageUrl)
            fetchfollow()
            
            
            
            
            
            
        }
    }
    
  
    
    let descriptionText : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    
      lazy var followbutton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("Loading", for: .normal)
          button.backgroundColor = .black
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 5
          button.isEnabled = true
          button.addTarget(self, action: #selector(followHandleTapped), for: .touchUpInside)
          return button
      }()
    
    
    let nameLebale: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let coverImg: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    lazy var link : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("links", for: .normal)
        btn.backgroundColor = .orange
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 6
        btn.addTarget(self, action: #selector(linkpopup), for: .touchUpInside)
        return btn
     }()
    
    @objc func linkpopup() {
           self.delegate.linkpopup(for: self)
        
         }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    lazy var followersLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .gray
        //add gesture recognizer
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5

//        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
//        followTap.numberOfTapsRequired = 1
        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(followTap)
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
    
        
        addSubview(coverImg)
        coverImg.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor , paddingtop: 0, paddingleft: 0, paddingbottom: 0, paddingright: 0, width:  0, height: 150)
       
        addSubview(followersLabel)
              followersLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingtop: -10, paddingleft: 0, paddingbottom: 0, paddingright: 20, width: 70, height: 60)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingtop: 100, paddingleft: 35, paddingbottom: 0, paddingright: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 8
        
        addSubview(nameLebale)
        nameLebale.anchor(top: coverImg.bottomAnchor, left: profileImageView.rightAnchor , bottom: nil, right: nil, paddingtop: 7, paddingleft: 10, paddingbottom: 0, paddingright: 0, width: 0, height: 0)
       
        addSubview(followbutton)
        followbutton.anchor(top: coverImg.bottomAnchor, left: nameLebale.rightAnchor, bottom: nil, right: nil, paddingtop: 5, paddingleft: 10, paddingbottom: 0, paddingright: 0, width: 70, height: 0)
        addSubview(link)
        link.anchor(top: coverImg.bottomAnchor, left: followbutton.rightAnchor, bottom: nil, right: self.rightAnchor, paddingtop: 5, paddingleft: 10, paddingbottom: 0, paddingright: 30, width: 50, height: 0)
                  
             
             
        addSubview(descriptionText)
               descriptionText.anchor(top: followbutton.bottomAnchor , left: self.leftAnchor, bottom: nil, right: rightAnchor, paddingtop: 10, paddingleft: 10, paddingbottom: 10, paddingright: 20 , width: 0, height: 0)
      
    }
    
    
    
    
    func configureFollowProfileButton() {
        followbutton.setTitleColor(.white, for: .normal)
        
        followbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        
        band?.checkIfBandIsFollowed(completion: { (followed) in
            if followed {
                self.followbutton.setTitle("following", for: .normal)
            }else{
                self.followbutton.setTitle("follow", for: .normal)
                
            }
        })
        
    }
    
    
    
    
   
    
    
    
    
    
    @objc func followHandleTapped() {
        
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
    func fetchfollow() {
        
        
           
           guard let groupname = band?.name else {return}
        
        print(groupname)
           Database.database().reference().child("bandfollowers").child(groupname).observe(.value) { (snapshot) in
               
               var key = snapshot.childrenCount
               print(key)
               let attributedText = NSMutableAttributedString(string: "Followers\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
               
               attributedText.append(NSAttributedString(string: "\(key)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.black]))
               
            self.followersLabel.attributedText = attributedText
               
               print(key)
      
           
               
           }
       }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
