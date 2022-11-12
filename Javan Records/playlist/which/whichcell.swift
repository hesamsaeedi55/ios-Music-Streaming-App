//
//  whichcell.swift
//  Javan Records
//
//  Created by Hesamoddin on 9/12/20.
//  Copyright © 2020 Hesamoddin. All rights reserved.
//

import UIKit

class whichcell: UITableViewCell {
    var albumname : String?

    var playlistname : String? {
        didSet {
            
            let name = playlistname
            self.textLabel?.text = name
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
