//
//  genrecells.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/20/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit

class genrecells: UITableViewCell {
    
    var genre:Genre? {
        didSet {
            var name = genre?.nameid
            var img  = genre?.img
            label.text = name
        }
    }

    lazy var label: UILabel = {
        var label = UILabel()
        
        label = UILabel(frame: CGRect( x: 0 , y: 0, width: 100, height: 50))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
           return label
       }()

   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    
//    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
//
   
     
       self.selectionStyle = .none
    
       
   }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        //super.layoutsubviews hatman bayad neveshte shavad
        super.layoutSubviews()
        
        
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        
        
        contentView.layer.cornerRadius = 20
        
        textLabel?.center.y = self.contentView.center.y - 10
        textLabel?.center.x = self.contentView.center.x - 10
        label.center = contentView.center
        addSubview(label)

        

        
    }
  

}
