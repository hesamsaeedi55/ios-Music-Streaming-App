//
//  TableViewCell.swift
//  Javan Records
//
//  Created by Hesamoddin on 6/25/21.
//  Copyright © 2021 Hesamoddin. All rights reserved.
//

import UIKit




class songCell: UITableViewCell {
    
    
    var songname: Track? {
        didSet {
            let name = songname?.name
            lbl.text = name
            img.loadImage(with: (songname?.img!)!)
            
        }
    }
    
    lazy var lbl: UILabel = {
          let button = UILabel()
         button.numberOfLines = 0
          return button
      }()
     
    
    lazy var img : CustomImageView = {
         let photo = CustomImageView()
         photo.contentMode = .scaleAspectFill
         photo.clipsToBounds = true
         photo.backgroundColor = .black
         photo.layer.cornerRadius = 10
         return photo
     }()
    
    lazy var numberDownload: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: .value1, reuseIdentifier: reuseIdentifier)
      
        addSubview(lbl)
          lbl.anchor(top: self.topAnchor, left: nil , bottom: nil, right: nil, paddingtop: 10, paddingleft: 0, paddingbottom: 10, paddingright: 10, width: 80, height: 30)
          lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
              addSubview(img)
                    img.anchor(top:nil, left: self.leftAnchor , bottom: nil , right: lbl.leftAnchor , paddingtop: 10, paddingleft: 5, paddingbottom: 0, paddingright: 10, width: 50, height: 50)
                    img.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


        
//        addSubview(numberDownload)
//        numberDownload.anchor(top: self.topAnchor, left: textLabel?.rightAnchor, bottom: self.topAnchor, right: nil, paddingtop: 20, paddingleft: 50, paddingbottom: 0, paddingright: 0, width: numberDownload.frame.origin.x, height: numberDownload.frame.origin.y)
//             numberDownload.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 30, y: textLabel!.frame.origin.y - 2, width: (100), height: (textLabel?.frame.height)!)
             textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
             textLabel?.numberOfLines = 0
             
    }

}
