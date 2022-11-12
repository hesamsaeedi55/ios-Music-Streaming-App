//
//  genreVC.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/19/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class genreVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var genres:genre?
    
    var genreList = [genre]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Register cell classe
        
        self.collectionView.register(genreCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        fetchGenres()

   

        // Do any additional setup after loading the view.
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
        return genreList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! genreCell
        
        cell.genres = genreList[indexPath.item]
    
        // Configure the cell
    
        return cell
    }
    
    func fetchGenres() {
        Database.database().reference().child("category").observe(.childAdded) { (snapshot) in
            
            let genres = snapshot.key
            
            let genrenames = genre(nameid: genres)
            
            self.genreList.append(genrenames)
            
            print(genrenames.nameid)
            
        }
    }

    


}
