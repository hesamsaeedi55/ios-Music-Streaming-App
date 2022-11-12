//
//  profileVC.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/6/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase


private let reuseIdentifier = "Cell"
private let headerIdentifire = "profileHeader"


class profileVC: UICollectionViewController,UICollectionViewDelegateFlowLayout, alert {
   
    
    var albumImg : String?
    var tracks = [Song]()
    var band:Band?
    var album = [albumList]()
    var bands = [Band]()
    var isadmin = false
    var bandName : String?
    lazy var functions = Functions.functions()
    
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "photo-1539888554388-a6c923ee102e")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        fetchalbums()

        self.collectionView.register(profileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:headerIdentifire)
        
        self.collectionView.register(albumVC.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        self.collectionView.backgroundColor = .white
        isadminer()
        dothat()
                
    }
    
    
    
    func isadminer() {
        guard let bandadmin = band?.admin else {return}
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        if bandadmin == currentUid {
            print("yes")
            isadmin = true
        }else{
            isadmin = false
        }
        
    }
    
    
   func linkpopup(for cell: profileHeader) {
    
          let alert = UIAlertController(title: "other social media", message: nil, preferredStyle: .actionSheet)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

       

          alert.addAction(UIAlertAction(title: "Instagram", style: .default, handler: { action in

               let Username =  "instagram" // Your Instagram Username here
                 let appURL = URL(string: "instagram://user?username=\(Username)")!
                 let application = UIApplication.shared

                 if application.canOpenURL(appURL) {
                     application.open(appURL)
                 } else {
                     // if Instagram app is not installed, open URL inside Safari
                     let webURL = URL(string: "https://instagram.com/\(Username)")!
                     application.open(webURL)
                 }
          }))
    alert.addAction(UIAlertAction(title: "Youtube", style: .default, handler: { action in

                 if let name = alert.textFields?.first?.text {
                     print("Your name: \(name)")
                 }
             }))
    alert.addAction(UIAlertAction(title: "Twitter", style: .default, handler: { action in

                 if let name = alert.textFields?.first?.text {
                     print("Your name: \(name)")
                 }
             }))

          self.present(alert, animated: true)
      }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 90) / 3
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
  
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

 

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(album.count)
        return album.count
    }




    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifire, for: indexPath) as! profileHeader
        
        header.band = self.band
        header.delegate = self
        return header
        
        
    }
  
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let albumname = album[indexPath.item].nameid else {return}
        
        print("yeah")
        print(albumname)
      
       

       let tracktable = nameoftracks()
        
        
       tracktable.albumTitle = albumname
       tracktable.name = albumname
       tracktable.bandName = bandName
        
        
       self.navigationController?.pushViewController(tracktable.self, animated: true)
                
                
                
//
//        Database.database().reference().child("tracks").child("aenima").observeSingleEvent(of: .value, with: { (snapshot) in
//
//                let nametrack = snapshot.value
//
//                print(nametrack)
//
//                guard let dictionary = nametrack as? Dictionary<String,AnyObject> else {return}
//
//                let track = Song(dictionary: dictionary)
//
//                self.tracks.append(track)
//
//
//            print(self.tracks)
//
//
//
//
//
//
//
//        })
//
        
        
        
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! albumVC
     
        cell.albums = album[indexPath.item]
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor(displayP3Red: 112, green: 124, blue: 5, alpha: 0.5)

        navigationItem.title = band?.name
        return cell
    }
    
    func fetchalbums() {
        
        guard let bandname = band?.nameid else {return}
        
        Database.database().reference().child("albums").child(bandname).observe(.childAdded) { (snapshot) in
            
            let albumname = snapshot.key
             print(albumname)
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
            
            let albumnames = albumList(nameid: albumname, dictionary: dictionary)
            
            self.album.append(albumnames)
            
            self.collectionView?.reloadData()

            
            print(albumnames.nameid)
        }
        
        
    }
    func dothat() {
    
    functions.httpsCallable("addMessage").call(["text": "hesam"]) { (result, error) in
        
      if let error = error as NSError? {
        if error.domain == FunctionsErrorDomain {
            _ = FunctionsErrorCode(rawValue: error.code)
            _ = error.localizedDescription
            _ = error.userInfo[FunctionsErrorDetailsKey]
        }
        // ...
      }
      if let text = (result?.data as? [String: Any])?["text"] as? String {
        print(text)
      }
    }
    
    }

}
