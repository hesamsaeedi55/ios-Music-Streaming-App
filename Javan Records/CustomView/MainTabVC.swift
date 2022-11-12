//
//  MainTabVC.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/26/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.delegate = self
        
        configureViewController()
        checkIfUserLoggedIn()
        print("did")
        
        

    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func configureViewController () {
        
        let genre = configuerNavigationController(unselectedimg:#imageLiteral(resourceName: "12profile_unselected"), selectedimg: #imageLiteral(resourceName: "12profile_unselected"), root: genreVC())
        
        let search = configuerNavigationController(unselectedimg:#imageLiteral(resourceName: "pro2file_unselected"), selectedimg: #imageLiteral(resourceName: "pro2file_unselected"), root: SongSearchVC())

        let ps = configuerNavigationController(unselectedimg:#imageLiteral(resourceName: "profile_unselected-1"), selectedimg: #imageLiteral(resourceName: "profile_unselected-1"), root: playlist())
        
        let ProfileVC =  configuerNavigationController(unselectedimg: #imageLiteral(resourceName: "profile_unselected"), selectedimg: #imageLiteral(resourceName: "profile_unselected"),root: UserVC(collectionViewLayout:UICollectionViewFlowLayout()))
        
        
        viewControllers = [genre,search,ps,ProfileVC]
        
        
    }
    
   func configuerNavigationController(unselectedimg: UIImage, selectedimg: UIImage,root: UIViewController = UIViewController())->UINavigationController {
        //construct nav controller
        let navController = UINavigationController(rootViewController: root)
        navController.tabBarItem.image = unselectedimg
        navController.tabBarItem.selectedImage = selectedimg
        navController.navigationBar.tintColor = .black
        //return nav controller
        return navController
    }
    
    
    
    
    
    
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            print("user is out")
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginVC())
                self.present(navController,animated: true,completion: nil)
            }
        }
        return
    }


}
