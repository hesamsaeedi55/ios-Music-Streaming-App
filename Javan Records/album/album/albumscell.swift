//
//  trackcell.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/1/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class albumcell: UITableViewCell {
    
    var delegate : albumcell?
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    
    
    lazy var playbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("play", for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    

    var albumha:albumList? {
        didSet {
        
            let name = albumha?.nameid
            
            self.textLabel?.text = name

            print(name)
            
        }
    }
    
    
    
  
    
    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/javan-b82d7.appspot.com/o/cigar.mp3?alt=media&token=94a9eaaa-b324-4b39-8167-688fefe4331c")
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        
        
        
        self.selectionStyle = .none
        
        
    }
    
    
    
    override func layoutSubviews() {
        //super.layoutsubviews hatman bayad neveshte shavad
        super.layoutSubviews()
        
       
    
        
        addSubview(playbutton)
        playbutton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingtop: 0, paddingleft: 0, paddingbottom: 0, paddingright: 12, width: 90, height: 30)
        playbutton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        playbutton.layer.cornerRadius = 5


        
        
        
        textLabel?.frame = CGRect(x: 68, y: textLabel!.frame.origin.y - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        
        
        
        
        
    }
    
    
    
    @objc func playButtonTapped()
    {
        
         play()
   
    }
    
    func play() {
        print(player?.rate)
        if player?.rate == 0
        {
            player!.play()
            print("done")
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playbutton.setTitle("Pause", for:.normal)
        } else {
            player!.pause()
            print("done again")
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playbutton.setTitle("Play", for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
