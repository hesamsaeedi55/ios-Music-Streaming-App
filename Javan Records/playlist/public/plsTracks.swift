//
//  plsTracks.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/13/20.
//  Copyright © 2020 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

var nameOf:String = "any"
private let reuseIdentifire = "SearchUserCell"

var idSongs : String?
var songNames : String?

class plsTracks: UITableViewController,what2 {
  
    
    
    


         var player:AVPlayer?
         var playerItem:AVPlayerItem?
         var playButton:UIButton?
    
        
    
    
    struct myVar {
        
        static var name:String!
        static var format = ".mp3"
        static var filename = myVar.name + myVar.format

    }
    
    
    

    

    
    
    
    
    
    func playButtonTapped(for cell: plsTrackCellTableViewCell) {
           
             pause(for: cell)
                
             myVar.filename = (idSong)! + (songName)! + myVar.format
                     let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                               let url = NSURL(fileURLWithPath: path)
                     print(url)
                     if let pathComponent = url.appendingPathComponent(myVar.filename) {
                         print(pathComponent)
                                   let filePath = pathComponent.path
                                   let fileManager = FileManager.default
             
             
                         if (player?.rate == 0 || player?.rate == nil ) && ( cell.playbutton.titleLabel?.text == "play" || cell.playbutton.titleLabel?.text == "demo") {
             
             
             
                                  if fileManager.fileExists(atPath: filePath) {
             
             
             
                          let playerItem:AVPlayerItem = AVPlayerItem(url:pathComponent)
                                                      self.player = AVPlayer(playerItem: playerItem)
                                                      let playerLayer=AVPlayerLayer(player: self.player!)
                                                      playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
                                                      cell.layer.addSublayer(playerLayer)
             


                    
             
                                     NotificationCenter.default.addObserver(cell, selector: #selector(cell.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                                     
                                   
                                   
             
             
                           player!.play()
                                     cell.playbutton.setTitle("pause", for: .normal)
                                     cell.playbutton.backgroundColor = UIColor(displayP3Red: 235/255, green: 146/255, blue: 52/255, alpha: 1)
                              //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
             
                                     print("0")
                                     
                             }
             
             
                          else{
             
             
                                     cell.playbutton.setTitle("play", for: .normal)
                                        guard let main = cell.trackers?.urlmain else {return}
                                        let trackmain = URL(string: main)
                                        let playerItem:AVPlayerItem = AVPlayerItem(url:trackmain!)
                                        self.player = AVPlayer(playerItem: playerItem)
                                        let playerLayer=AVPlayerLayer(player: self.player!)
                                        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
                                     cell.layer.addSublayer(playerLayer)
             
             //                               if player?.rate == 0 && ( playbutton.titleLabel?.text == "play" ||
             //                                playbutton.titleLabel?.text == "demo")
             
                                                player!.play()
                                                print("do")
                                     cell.playbutton.setTitle("pause", for: .normal)
                                     cell.playbutton.backgroundColor = UIColor(displayP3Red: 235/255, green: 146/255, blue: 52/255, alpha: 1)
                                                   //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
                                                 print("1")
             
             //                                  } else {
             //                                   player?.seek(to: CMTime.zero)
             //                                   player?.pause()
             //                                   playbutton.setTitle("play", for: .normal)
             //                                   playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
             //                                      //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
             //                                  }
             
                             }
                             }
             
                         else{
                 
                             pause(for: cell)
                         }
             
                     }
             
    }
    
    
    func pause(for cell : plsTrackCellTableViewCell) {

        player?.seek(to: CMTime.zero)
        player?.pause()
        cell.playbutton.setTitle("play", for: .normal)
        cell.playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        
        
        
        
        
        
    }
    
    

    var tracks = [Song]()
    var plsTitle : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = plsTitle
        fetchTrack(plsTitle!)
        print(nameOf)
        
        tableView.register(plsTrackCellTableViewCell.self, forCellReuseIdentifier: reuseIdentifire)
        
        
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! plsTrackCellTableViewCell
        cell.delegate = self

        cell.trackers = tracks[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func fetchTrack(_ name : String) {
        
        Database.database().reference().child("pls").child(name).observe(.childAdded) { (snap) in
            
            if snap.key != "owner" {
                
                Database.database().reference().child("pls").child(name).child(snap.key).observeSingleEvent(of: .value) { (snapshot) in
                    
             
                    
                    let key = snapshot.key
                    let value = snapshot.value
                    
                    print(key)
                    
                    guard let dictionary = value as? Dictionary<String,AnyObject> else {return}
                    let song = Song(id: key, dictionary: dictionary)
                    self.tracks.append(song)
                    
                    self.tableView.reloadData()
                    
                    }
                }
                
            }
            
        }



}
