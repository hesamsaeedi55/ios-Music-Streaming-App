//
//  CustomImageView.swift
//  InstagramCopy
//
//  Created by Hesamoddin on 11/2/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit




class CustomImageView: UIImageView {
    
    var imageCache = [String: UIImage]()

    var lastImgUrlUsedToLoadImage:String?

    
     func loadImage(with urlstring: String) {
        //check -> ax dar cache vujud darad ya na
        
        //set image to nil
        self.image = nil
    
        //set lastImageUrlUsedToLoadImage
        lastImgUrlUsedToLoadImage = urlstring
        
        
        if let cachedImage = imageCache[urlstring] {
            self.image = cachedImage
            return
        }
        //if image doesnt exist in cache
        
        //url location of image
        guard let url = URL(string: urlstring) else {return}
        
        //fetch contents of URL
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //handle error
            if let error = error {
                print(error.localizedDescription)
            }
            
            if self.lastImgUrlUsedToLoadImage != url.absoluteString {
                return
                
            }
            
            
            // image data
            guard let imageData = data else {return}
            
            //create using image data
            let photoImage = UIImage(data: imageData)
            
            //set key and value for image cache or ===>  imageCache[urlString] = photoImage
            self.imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
    
    
}
