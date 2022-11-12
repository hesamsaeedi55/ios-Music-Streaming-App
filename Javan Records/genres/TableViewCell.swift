//
//  TableViewCell.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/12/20.
//  Copyright © 2020 Hesamoddin. All rights reserved.
//
import UIKit




class playlistCells: UITableViewCell {
    
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
