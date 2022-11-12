//
//  nameoftracks.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/7/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifire = "SearchUserCell"

class playlist: UITableViewController , UISearchBarDelegate{
    
    var tracks = [Song]()
    var pls = [Playlist]()
    var cpls = [String]()
    var searchBar = UISearchBar()
    var inSearchMode = false
    var filteredBands = [Playlist]()
    
    var name: String?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureSearchBar()
        
        
          let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusplay))
        navigationItem.rightBarButtonItems = [add]
        
        fetchplaylist()

        tableView.register(playlistCells.self, forCellReuseIdentifier: reuseIdentifire)

        self.navigationItem.title = "playlist"
    }
    
 
 

     
    @objc func plusplay() {
        
           let alerts = UIAlertController(title: "Alert", message: "this Id is not available,try another", preferredStyle: UIAlertController.Style.alert)

        
        let alert = UIAlertController(title: "Alert", message: "choose playlist id ", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (txt) in
            txt.placeholder = "playlist name"
        }
        
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
               
               
               print("public")
               
           }
                   ))
        
        alert.addAction(UIAlertAction(title: "create", style: UIAlertAction.Style.default, handler: {action in
            
            let txt = alert.textFields![0]
            
        if self.cpls.contains("\(txt.text!)") {
                
            
                print("exist")
            alerts.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: nil))

            self.present(alerts, animated: true, completion:nil)
                

                
                    
                 
            }else{
                print("doesnt")
                Database.database().reference().child("playlist").child(Auth.auth().currentUser!.uid).updateChildValues(["\(txt.text!)" : "1" ])
                
                
                
                 Database.database().reference().child("pls").child("\(txt.text!)").updateChildValues(["owner" :
                    "\(Auth.auth().currentUser!.uid)"])
                
            }
              

            }))

        
        
        
        
        
        
             self.present(alert, animated: true, completion: nil)
        
   
        
             }
    


    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var bandscell: Playlist!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! playlistCells
        
    if inSearchMode {
                      bandscell = filteredBands[indexPath.row]
                  }else{
                      bandscell = pls[indexPath.row]
                  }
        cell.pls = bandscell

        
        return cell
        
    }
    
    
    
    
    func configureSearchBar() {
         searchBar.sizeToFit()
        searchBar.delegate = self
         navigationItem.titleView = searchBar
         searchBar.barTintColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
         searchBar.tintColor = .black
     }
     
    
    
    
     func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         searchBar.showsCancelButton = true
     }
    
    
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         let searchText = searchText.lowercased()
         
         if searchText.isEmpty || searchText == " " {
             inSearchMode = false
            tableView.reloadData()
         }else{
             inSearchMode = true
            filteredBands = pls.filter({ (banders) -> Bool in
                return banders.name.contains(searchText)
            })
            tableView.reloadData()
         }
     }
    
    
    
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.endEditing(true)
         searchBar.showsCancelButton = false
         searchBar.text = nil
        inSearchMode = false
        tableView.reloadData()
          
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
        
         if inSearchMode {
                  return filteredBands.count
              }else{
                  return pls.count
              }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let plstrackvc = plsTracks()
        let cell = pls[indexPath.row].name
        fetchTrack(cell!)
        plstrackvc.plsTitle = cell
        self.navigationController?.pushViewController(plstrackvc, animated: true)

    }
    
    
    
    
     func fetchplaylist() {
          Database.database().reference().child("pls").observe(.childAdded) { (snapshot) in
                
              print(snapshot.key)
                
                Database.database().reference().child("pls").child(snapshot.key).observeSingleEvent(of: .childAdded) { (snap) in
                    
               
                    
                  let key = snapshot.key
                  print(snapshot.key)
                    
                    let value = snapshot.value
                    
                
                    
                    guard let dictionary = value as? Dictionary<String,AnyObject> else {return}
                    
                  let pl = Playlist(name: snapshot.key, dictionary: dictionary)
                    
                    
                    self.pls.append(pl)
                    self.cpls.append(pl.name)
                       self.tableView.reloadData()
                    
                }
             
                
            }

      }
    
    
    func fetchTrack(_ name : String) {
        
//        Database.database().reference().child("pls").child(name).observe(.childAdded) { (snap) in
//            
//            if snap.key != "owner" {
//                
//                Database.database().reference().child("pls").child(name).child(snap.key).observeSingleEvent(of: .value) { (snapshot) in
//                    
//             
//                    
//                    let key = snapshot.key
//                    let value = snapshot.value
//                    
//                    print(key)
//                    
//                    guard let dictionary = value as? Dictionary<String,AnyObject> else {return}
//                    let song = Song(id: key, dictionary: dictionary)
//                    self.tracks.append(song)
//                    
//                    print(self.tracks[0].name)
//                    }
//                }
//                
//            }
            
        }
        
//        Database.database().reference().child("pls").child(name).observe(.childAdded) { (snap) in
//            if snap.key == "owner" {
//
//                Database.database().reference().child("users").child(snap.value! as! String).observe(.childAdded) { (snap) in
//
//                    if snap.key != "name" {
//                        print(snap.key)
//
//                    }else{
//                        print(snap.value)
//                    }
//
//                }
//
//
//    }
//
//    }
}

