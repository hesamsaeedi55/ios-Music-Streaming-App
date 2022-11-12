//
//  user.swift
//  InstagramCopy
//
//  Created by Hesamoddin on 10/6/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import Firebase

class User {
    
    //attributes
    var uid:String!
    var username: String!
    var name:String!
    var profileImageUrl: String!
    var password:String!
    
    
    init(uid:String,dictionary: Dictionary<String,AnyObject>) {
        self.uid = uid
        
        //"username" va ..., daqiqan bayad ham name maqadire kelidie database bashand
        
        if let username = dictionary["username"] as? String {
        self.username = username
    }
    
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = profileImageUrl
        }
        if let password = dictionary["password"] as? String {
            self.password = password
        }
    
}
    
    func checkIfBandIsFollowed(completion:@escaping(Bool)->()) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("bandfollowers").child(self.name)
        
    }
    
}

class Genre {
    var nameid : String!
    var img : String!
    init(nameid:String,dictionary:Dictionary<String,AnyObject>) {
        self.nameid = nameid
        
        if let img = dictionary["img"] as? String {
        self.img = img
        }
    }
}

class whatname {
    var name : String!
    
    init(name:String) {
        self.name = name
    }
}

class Playlist {
    var owner : String!
    var name : String!
    init(name:String,dictionary : Dictionary<String,AnyObject>) {
        self.name = name
        
        if let owner = dictionary["name"] as? String {
            self.owner = owner
        }
        
    }
}

class Band {
    
    var nameid: String!
    var name: String!
    var admin: String!
    var description: String!
    var imgUrl: String!
    var members: String!
    var proImgUrl: String!
    
    init(nameid:String,dictionary: Dictionary<String,AnyObject>) {
       self.nameid = nameid
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        if let imgUrl = dictionary["imgUrl"] as? String {
            self.imgUrl = imgUrl
        }
        if let members = dictionary["members"] as? String {
            self.members = members
        }
        if let proImgUrl = dictionary["proImgUrl"] as? String {
            self.proImgUrl = proImgUrl
        }
        if let admin = dictionary["admin"] as? String {
            self.admin = admin
        }
    }
    
    func checkIfBandIsFollowed(completion:@escaping(Bool)->()) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("bandfollowings").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
            if snapshot.hasChild(self.name) {
            completion(true)
            }else{
            completion(false)
            }
    }
    }
    
}

class Track {
    var name : String!
    var band : String!
    var album : String!
    var img : String!
    
    init(name:String,dictionary:Dictionary<String,AnyObject>) {
        self.name = name
        
   
        if let album = dictionary["album"] as? String {
            self.album = album
        }
        if let band = dictionary["band"] as? String {
               self.band = band
           }
        if let img = dictionary["img"] as? String {
            self.img = img
        }
    }
}




class albumList {
    
    
    var nameid: String!
    var bandname : String!
    var linkid: String!
   
    
    init(nameid:String,dictionary: Dictionary<String,AnyObject>) {
    
    self.nameid = nameid
    
        if let linkid = dictionary["imgUrl"] as? String {
            self.linkid = linkid
        }
        if let bandname = dictionary["band"] as? String {
            self.bandname = bandname
        }
       
    }
}

class Song {
    
    var trackNumber: String!
    var name: String!
    var url: String!
    var buy: String!
    var urlmain: String!
    var id: String!
    var price: String!
    
    init(id:String, dictionary: Dictionary<String,AnyObject>) {
        
        self.id = id
    
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let url = dictionary["url"] as? String {
            self.url = url
        }
        if let urlmain = dictionary["urlmain"] as? String {
            self.urlmain = urlmain
        }
        if let buy = dictionary["buy"] as? String {
            self.buy = buy
        }
        if let trackNumber = dictionary["tracknumber"] as? String {
            self.trackNumber = trackNumber
        }
        if let price = dictionary["price"] as? String {
            self.price = price
        }
         
    }
    
    func checkIfSongIsBought(completion:@escaping(Bool)->()) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("userOwnedAlbums").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            
          
            if snapshot.hasChild(self.id) {
                completion(true)
            }else{
                completion(false)
            }
        }
        
      
    }
    
}

extension Database {

    static func fetchps(with postId: String,completion : @escaping(Playlist)->()) {
        Database.database().reference().child("pls").observe(.childAdded) { (snapshot) in
        
                      print(snapshot.key)
        
                        Database.database().reference().child("pls").child(snapshot.key).observeSingleEvent(of: .childAdded) { (snap) in
        
        
        
                          let key = snapshot.key
        
                            let value = snapshot.value
                            guard let dictionary = value as? Dictionary<String,AnyObject> else {return}
                            let ps = Playlist(name: key, dictionary: dictionary)
                            print(ps.name as Any)
                            completion(ps)
                            
                            
    }
}
}
}


