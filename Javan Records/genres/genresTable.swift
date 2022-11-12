//
//  TableViewController.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/20/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifire = "searchgenres"


class genreVC: UITableViewController,UISearchBarDelegate{
    
     var user : User?
     var genrelist = [Genre]()
   

    
    
    var functions = Functions.functions()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.backgroundColor = .white
        
        tableView.separatorStyle = .none
        
        
        fetchGenres()
        
        tableView.register(genrecells.self, forCellReuseIdentifier: reuseIdentifire )

        let functions = Functions.functions()

     

            functions.httpsCallable("testFunction").call("Hi", completion: {(result,error) in
                if let error = error{
                    print("An error occurred while calling the test function: \(error)" )
                }
                print("Results from test cloud function: \(result)")
                           
        })
        
        configureNavigation()

    }
    
    

    
    
    
    
    func configureNavigation() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(handlelogout))
        
    }
    
    @objc func handlelogout() {
        
        //declae alert controller
        let alert = UIAlertController(title: "are you sure?", message: nil, preferredStyle: .alert)
            
            //background color
           // alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.green
            
            //add alert logout action
            alert.addAction(UIAlertAction(title: "logout" , style: .destructive, handler: { (_) in
                
                
                //attempt sign out
                do {
                try Auth.auth().signOut()
                    let lvc = LoginVC()
                    let navController = UINavigationController(rootViewController: lvc)
                    self.present(navController, animated: true, completion: nil)
                    print("seccussfully logged out")
                }catch{
                    print("failed to signout")
                    
                }
            }))
            
            
            //add cancel action
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    


    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
      }
      
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return genrelist.count
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! genrecells
           
        
        cell.genre = genrelist[indexPath.row]
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        
       
        
        
        
        if indexPath.row == 0 {
            
            let image = UIImage(named: "1")
            imageView.image = image
            cell.backgroundView = UIView()
            imageView.contentMode = .scaleToFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 30
            cell.backgroundView?.addSubview(imageView)
      
      
      
        }else if indexPath.row == 1 {
            
            let image = UIImage(named: "arp-2600-100120-616x440")
            imageView.image = image
            cell.backgroundView = UIView()
            imageView.contentMode = .scaleToFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 30
            cell.backgroundView?.addSubview(imageView)

            
            
        }else if indexPath.row == 2 {
            
            let image = UIImage(named: "222")
            imageView.image = image
            cell.backgroundView = UIView()
            imageView.contentMode = .scaleToFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 30
            cell.backgroundView?.addSubview(imageView)
            
            
            
        }else if indexPath.row == 3 {
            
            let image = UIImage(named: "111")
            imageView.image = image
            cell.backgroundView = UIView()
            imageView.contentMode = .scaleToFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 30
            cell.backgroundView?.addSubview(imageView)

            
            
        }else if indexPath.row == 4 {
       
            let image = UIImage(named: "11")
            imageView.image = image
            cell.backgroundView = UIView()
            imageView.contentMode = .scaleToFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 30
            cell.backgroundView?.addSubview(imageView)

       
        }
        
        cell.layer.cornerRadius = 30 //set corner radius here
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 10 // set border width here
        
           return cell
       }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let genre = genrelist[indexPath.row]
        
        let bandVC = searchVC()
        
        bandVC.bandels = genre
        
        navigationController?.pushViewController(bandVC, animated: true)
        
    }
    
    
     func fetchGenres() {
        
         Database.database().reference().child("category").observe(.childAdded) { (snapshot) in
             
             let genre = snapshot.key
            
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}

            let genrenames = Genre(nameid: genre,dictionary: dictionary )
             
             self.genrelist.append(genrenames)
             
            
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

   
}
