//
//  nameoftracks.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/7/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation


var idSong : String?
var songName : String?

private let reuseIdentifire = "SearchUserCell"

class nameoftracks: UITableViewController, goto,done,what  {
 
    
 
    

    struct myVar {
        
        static var name:String!
        static var format = ".mp3"
        static var filename = myVar.name + myVar.format

    }

    
    

      var player:AVPlayer?
      var playerItem:AVPlayerItem?
      var playButton:UIButton?
 
     
    var alimg : String?
    var tracks = [Song]()
    var songID : String?
    var name: String?
    var albumTitle: String?
    var bandName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImg()
        
   
        navigationItem.title = albumTitle
        
        fetchTracks()
       

        
        tableView.register(tracksTableViewCell.self, forCellReuseIdentifier: reuseIdentifire)

        
        
    }
    
  let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
    
    
    
    
      func playButtonTapped(for cell: tracksTableViewCell) {
        
        
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
                                cell.playbutton.setTitle("pause", for: .normal)
                                cell.playbutton.backgroundColor = UIColor(displayP3Red: 235/255, green: 146/255, blue: 52/255, alpha: 1)
                                              //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
        
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
    
   
    
    
    func pause(for cell : tracksTableViewCell) {

        player?.seek(to: CMTime.zero)
        player?.pause()
        cell.playbutton.setTitle("play", for: .normal)
        cell.playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        
    }
    
    
    func addButtonTapped(for cell: tracksTableViewCell) {
  
        
        Database.database().reference().child("tracks").child("\(albumTitle!)").child(idSong!).observeSingleEvent(of: .value) { (snap) in

            
 
              guard let dictionary = snap.value as? Dictionary<String,AnyObject> else {return}
              let song = Song(id: snap.childSnapshot(forPath: "id").value! as! String, dictionary: dictionary)
              print(song.id as Any)
              print(snap.key)
            
         ahang = song
             
         }
        
//        Database.database().reference().child("tracks").child("\(albumTitle!)").child("\(songID!)").observe(.childAdded) { (snap) in
//
//            print(snap.childSnapshot(forPath: "id").value! as Any)
//            guard let dictionary = snap.value as? Dictionary<String,AnyObject> else {return}
//            let song = Song(id: snap.childSnapshot(forPath: "id").value! as! String, dictionary: dictionary)
//            print(song.id as Any)
//
//        }
        
//        let name = cell.textLabel?.text
//        thissong = name!
//        thisalbum = albumTitle!
        navigationController?.pushViewController(which(), animated: true)
     
                }
    
    func downloadCompleted(for cell: tracksTableViewCell) {
           print("sss")
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
            self.alert.dismiss(animated: true, completion: nil)
        }
       }
            

    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! tracksTableViewCell
        
        cell.albumImg = alimg
        cell.trackers = tracks[indexPath.row]
        
        cell.albumname = name
        
        cell.delegate = self
        cell.delegate2 = self
        cell.delegate3 = self
        
        return cell
        
        

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let this = tracks[indexPath.row]
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tracks.count

    }
    
    
    func fetchImg() {
        
        Database.database().reference().child("albums").child(bandName!).child(albumTitle!).observe(.childAdded) { (snap) in
            
            self.alimg = snap.value as! String
            
        }
        
    }
    
    
    func fetchTracks() {
        
        guard let namealbum = self.name else {return}
        print(namealbum)
        
        Database.database().reference().child("tracks").child(namealbum).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            Database.database().reference().child("tracks").child(namealbum).child(key).observeSingleEvent(of: .value) { (snapshot) in
                
                let key = snapshot.key
                let value = snapshot.value
                
                print(key)
                
                
                guard let dictionary = value as? Dictionary<String,AnyObject> else {return}
                
                let songs = Song(id: key, dictionary: dictionary)
                
                self.tracks.append(songs)
                
                
                self.tableView.reloadData()
            }
            
    }

    }
}
