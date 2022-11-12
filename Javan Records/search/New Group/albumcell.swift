//
//  albumcell.swift
//  Javan Records
//
//  Created by Hesamoddin on 7/13/21.
//  Copyright © 2021 Hesamoddin. All rights reserved.
//

import UIKit

class albumsearchcell: UITableViewCell {
    
    var album : albumList? {
        didSet {
            let name = album!.nameid
            self.textLabel?.text = name
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
