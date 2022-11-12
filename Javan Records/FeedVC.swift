//
//  FeedVC.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/21/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        checkifuserisloggedin()
        validation()
        
        
        

        
    }
    
    func validation() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            
            let uid = snapshot.key
            
            print(uid)
            
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
