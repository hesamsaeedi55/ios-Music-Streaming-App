//
//  UserVC.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/27/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifire = "profileHeader"


class UserVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var albums = [albumList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.collectionView.register(userCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifire)
        
        self.collectionView.register(albumsBuy.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchbuyedAlbums()
        
        view.backgroundColor = .white
     

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = (view.frame.width - 60) / 3
           view.backgroundColor = .white
           return CGSize(width: width, height: width)
       }
    
    func collectionView(_ collectionView: UICollectionView,
               layout collectionViewLayout: UICollectionViewLayout,
               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
        
    }

 

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifire, for: indexPath) as! userCell
        
        return header
        
       
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! albumsBuy
    
        cell.albums = albums[indexPath.item]
    
        return cell
    }
    
    func fetchbuyedAlbums() {
        guard let uid = Auth.auth().currentUser?.uid else {return}

        
        Database.database().reference().child("userOwnedAlbums").child(uid).observe(.childAdded) { (snapshot) in
            
            let albumkey = snapshot.key
            
            
            let albumLink = snapshot.value
            
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}

            
            let album = albumList(nameid: albumkey,dictionary: dictionary)
            
            self.albums.append(album)
            
            self.collectionView.reloadData()
        }
        
        
    }
    



}
