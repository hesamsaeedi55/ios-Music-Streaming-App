//
//  tracksTableViewCell.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/7/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit




class playlistCell: UITableViewCell {
    
    var albumname : String?
    
    


    var pls : Playlist? {
        didSet {
            
            let plname = pls?.name
            self.textLabel?.text = plname
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
