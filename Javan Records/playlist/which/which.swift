//
//  which.swift
//  Javan Records
//
//  Created by Hesamoddin on 9/11/20.
//  Copyright © 2020 Hesamoddin. All rights reserved.
//
var ahang : Song!

import UIKit
import Firebase

private let reuseIdentifire = "SearchUserCell"

var thissong:String! = "something"
var thisalbum:String! = "sthelse"

class which: UITableViewController {

    
    
    var plist = [Playlist]()

    var name: String?
    var nameOfPlaylist = [String]()


    
   weak var delegate : nameoftracks!

  
    

    
   override func viewDidLoad() {
          super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newadd))
   
    fetchplist()
    
    tableView.register(whichcell.self, forCellReuseIdentifier: reuseIdentifire)


  

}
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! whichcell
         
         cell.playlistname = nameOfPlaylist[indexPath.row]
         
         cell.albumname = name
         
         return cell
         
     }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String(thissong))
        
        let pl = nameOfPlaylist[indexPath.row]
        let cu = Auth.auth().currentUser?.uid
        
        let idSong = ahang.id!
      
        Database.database().reference().child("pls").child(pl).child(idSong).updateChildValues([
            "id" : idSong,
            "name" : ahang.name!,
            "url" : ahang.url!,
            "urlmain" : ahang.urlmain
            
        ])
        
 
        }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return nameOfPlaylist.count

    }
    
    
    
    
    
    func fetchplist() {
        
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("playlist").child(uid!).observe(.childAdded) { (snap) in
            
            print(snap.key)
            let key = snap.key
            self.nameOfPlaylist.append(key)
            print(self.nameOfPlaylist)
            self.tableView.reloadData()
          
        }
        
      
        
    


        
        Database.database().reference().child("pls").observe(.childAdded) { (snapshot) in
              
            print(snapshot.key)
              
              Database.database().reference().child("pls").child(snapshot.key).observeSingleEvent(of: .childAdded) { (snap) in
                  
             
                  
                  let key = snapshot.key
                  print(snapshot.key)
                  
                  let value = snapshot.value
                  print(value)
              
                  
                  guard let dictionary = value as? Dictionary<String,AnyObject> else {return}
                  
                let pl = Playlist(name: snapshot.key, dictionary: dictionary)
                  
                  self.plist.append(pl)
                  
                     self.tableView.reloadData()
                  
                  
              }
           
              
          }
        
   
        
    }
    
    
    
    @objc func newadd() {
        
        let alert = UIAlertController(title: "new playlist", message: "name your playlist here", preferredStyle: .alert)
        
        alert.addTextField { (txts) in
            txts.placeholder = "name"
        }
        let txt = alert.textFields![0]
        
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { (this) in
            
            print("cancel")
            
        }))
        
        alert.addAction(UIAlertAction(title: "done", style: .default, handler: { (action) in
            
            let plname = txt.text!
            let cu = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("pls").observe(.childAdded) { (snap) in
                if plname == snap.key {
                    print("matched wrong")
                }else{
                      Database.database().reference().child("playlist").child(Auth.auth().currentUser!.uid).updateChildValues(["\(txt.text!)" : "1" ])

                   Database.database().reference().child("pls").child("\(txt.text!)").updateChildValues(["owner" : "\(Auth.auth().currentUser!.uid)"])
                }
            }
            

            
        }))
        self.present(alert,animated: true,completion: nil)
    }
    

}
