//
//  TableViewController.swift
//  Javan Records
//
//  Created by Hesamoddin on 6/25/21.
//  Copyright © 2021 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifires = "searchusercell"

class SongSearchVC: UITableViewController,UISearchBarDelegate {
    
    
    var searchBar = UISearchBar()
    var inSearchMode = false
    var filteredBands = [Track]()
    var filteredBanders = [Track]()
    var filteredArtists = [Track]()
    var pls = [Playlist]()
    var name = [Track]()

    var bname = [Track]()
    var aname = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true

        
        configureSearchBar()

        search()
        search2()
        search3()
        tableView.register(songCell.self, forCellReuseIdentifier: reuseIdentifires)


      
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifires, for: indexPath) as! songCell
        var names : Track!
        
        if indexPath.section == 0 {
            if inSearchMode {
             names = filteredBands[indexPath.row]
            }else{

            }
        }else if indexPath.section == 1 {
            if inSearchMode {
             names = filteredBanders[indexPath.row]
            }else{
            }
        }else if indexPath.section == 2 {
            if inSearchMode {
                names = filteredArtists[indexPath.row]
            }
        }
        
        
        cell.songname = names
        
        
        return cell
        
        
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
        label.text = "Songs"
        label.backgroundColor = UIColor.lightGray
        return label
        }else if section == 1 {
            label.text = "Albums"
            label.backgroundColor = UIColor.lightGray
            return label
        }else if section == 2{
            label.text = "Artist"
            label.backgroundColor = UIColor.lightGray
            return label
        }else{
            return label
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
        
        if inSearchMode {
            
            
             return filteredBands.count
            
        }else{
            
                  
            return 0
            
             }
            
        }else if section == 1{
            
            
            if  inSearchMode {
                
                return filteredBanders.count
                
            }else{
                
            return 0
                
        }
    }
        else if section == 2 {
            if inSearchMode {
                return filteredArtists.count
            }else{
                return 0
            }
        }else{
            return 0
        }
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
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
        let tp = filteredBands[indexPath.row]
        
        let tracktable = nameoftracks()
        
        tracktable.albumTitle = tp.album
        tracktable.name = tp.album
            tracktable.alimg = tp.img
        tracktable.bandName = tp.band
        self.navigationController?.pushViewController(tracktable.self, animated: true)
        }else if indexPath.section == 1{
            let tp = filteredBanders[indexPath.row]
            let tracktable = nameoftracks()
            tracktable.albumTitle = tp.name
            tracktable.name = tp.name
            tracktable.bandName = tp.band
            tracktable.alimg = tp.img
            self.navigationController?.pushViewController(tracktable.self, animated: true)

        }else if indexPath.section == 2 {
            let tp = filteredArtists[indexPath.row]
            
            let bandprofileVC = profileVC(collectionViewLayout: UICollectionViewFlowLayout())
            
            guard let select = tp.band else {return }
            guard let selecter = tp.name else {return}
           
            
            
            bandprofileVC.bandName = tp.name
            
            Database.database().reference().child("category").child(select).observe(.childAdded) { (snapshot) in
                
                for i in 0...1000 {
                    
                let key = snapshot.key
                print(key)
                
                    if key == selecter {
            
                          
                          
                              guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
                              
                              let band = Band(nameid: selecter, dictionary: dictionary)
                
                bandprofileVC.band = band
                        break
                    
                    }else{
                        return
                    }
                 
        }
                self.navigationController?.pushViewController(bandprofileVC, animated: true)
        
            }
    }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          let searchText = searchText.lowercased()
          
          if searchText.isEmpty || searchText == " " {
              inSearchMode = false
             tableView.reloadData()
          }else{
              inSearchMode = true
            
             filteredBands = name.filter({ (banders) -> Bool in
                return banders.name.contains(searchText)
             })
            filteredBanders = aname.filter({ (bandersa) -> Bool in
                return bandersa.name.contains(searchText)
            })
            filteredArtists = bname.filter({ (artists) -> Bool in
                return artists.name.contains(searchText)
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
    
    func search() {
        
      
        Database.database().reference().child("songs").observe(.childAdded) { (snap1) in
            let name = snap1.key
            guard let dictionary = snap1.value as? Dictionary<String,AnyObject> else {return}
            let song = Track(name: name, dictionary: dictionary)
            self.name.append(song)
            self.tableView.reloadData()
            }
        }
    
    func search2() {
          Database.database().reference().child("tracks").observe(.childAdded) { (snap2) in
              let name = snap2.key
              guard let dictionary = snap2.value as? Dictionary<String,AnyObject> else {return}
              let album = Track(name: name, dictionary: dictionary)
              self.aname.append(album)
              self.tableView.reloadData()
          }
      }
    
    func search3() {
        Database.database().reference().child("bands").observe(.childAdded) { (s) in
            let name = s.key
            guard let dictionary = s.value as? Dictionary<String,AnyObject> else { return }
            let band = Track(name: name, dictionary: dictionary)
            self.bname.append(band)
            self.tableView.reloadData()
        }
    }
    
  
    

    }
    
    
