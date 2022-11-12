//
//  SerachTableViewController.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/29/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifire = "SearchUserCell"


class searchVC: UITableViewController,UISearchBarDelegate {
    
    var searchBar = UISearchBar()
    var inSearchMode = false
    var filteredBands = [Band]()
    
    
    var bandels : Genre?
    
    var bands = [Band]()

    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()

      

        checkifuserisloggedin()
        
        if self.user == nil {
            fetchcurrentUid()
        }
        
        fetchbands()
       

        
        tableView.register(searchcell.self, forCellReuseIdentifier: reuseIdentifire )
        
     
        
        //joda konande (seprator)
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var bandscell: Band!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! searchcell
        
        if inSearchMode {
                   bandscell = filteredBands[indexPath.row]
               }else{
                   bandscell = bands[indexPath.row]
               }
        
        cell.band = bandscell
               
        
        
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
            filteredBands = bands.filter({ (banders) -> Bool in
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
          
     }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var bandscell: Band!
        
        let bandprofileVC = profileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        if inSearchMode {
                          bandscell = filteredBands[indexPath.row]
                      }else{
                          bandscell = bands[indexPath.row]
                      }
        bandprofileVC.bandName = bandscell.name
        bandprofileVC.band = bandscell
        

        navigationController?.pushViewController(bandprofileVC, animated: true)
        
//
//        print(band.name)
//
//        let albumsearch = albumsearchVC()
//
//        albumsearch.band = band
//
//        self.navigationController?.pushViewController(albumsearchVC, animated: true)
//
//
        }
    

    
    
    
    func followTappedButton(for cell: searchcell) {
        
        print("hey")
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        
        Database.database().reference().child("bandfollowers").child("tool").updateChildValues([currentUid : 1])
        
        Database.database().reference().child("bandfollowings").child(currentUid).updateChildValues(["tool" : 1])
        
        
        
    }
        
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredBands.count
        }else{
            return bands.count
        }
    
    }
    
        
   
    
    func fetchbands() {
        
        guard let select = self.bandels?.nameid else {return}
        

        Database.database().reference().child("category").child(select).observe(.childAdded) { (snapshot) in
            
        let bands = snapshot.key
            
            
                guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
                
                let band = Band(nameid: bands, dictionary: dictionary)
                
                
                self.bands.append(band)
            
            print(band.nameid)
                
                
                self.tableView.reloadData()
                
           
            
        }
        
   }
    
    
    func fetchcurrentUid() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        
        Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            
            let uid = snapshot.key
            
            print(uid)
            
            
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            
            self.user = user
            self.navigationItem.title = user.name
            
        }
        
        
        
    }

    func checkifuserisloggedin() {
       if Auth.auth().currentUser == nil {
            print("user is out")
        DispatchQueue.main.async {
       
        let navController = UINavigationController(rootViewController: LoginVC())
            self.present(navController, animated: true, completion: nil) }
        }
        return
    }


    
   
    
}
