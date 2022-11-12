//
//  tracksTableViewCell.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/7/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase



struct myVar {
    
    static var name:String!
    static var format = ".mp3"
    static var filename = myVar.name + myVar.format

}


class tracksTableViewCell: UITableViewCell,URLSessionDownloadDelegate {
    
    
    
    
    
    var albumname : String?
    var isExist = true
    var delegate2 : done!
    var delegate : goto!
    var delegate3 : what!
    var this: whatname?
    var albumImg : String?
    
    var trackers:Song? {
        didSet{
            
            

            let idSong = trackers?.id
            let nameTrack = trackers?.name
            lbl.text = nameTrack
            configureBuyedButton()
      
            myVar.name = trackers?.name
            myVar.filename = idSong! + myVar.name + myVar.format
            print(myVar.filename)
            check(name: myVar.filename)
                        
            
            let mainUrl = trackers?.urlmain
            
            
            print(albumImg)
            img.loadImage(with: albumImg!)
            
            configurePlayButton()
            
            
            
        }
    }
    
    lazy var lbl: UILabel = {
         let button = UILabel()
        button.numberOfLines = 1
        button.font = UIFont.systemFont(ofSize: 12)
         return button
     }()
    
  lazy var add: UILabel = {
       let button = UILabel()
       return button
   }()
    
    lazy var addtoPlaylist: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.isHidden = true
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

    
    lazy var playbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("play", for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    

    
    
    lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var showpr: UIButton = {
           let button = UIButton(type: .system)
           button.setTitleColor(.white, for: .normal)
           button.setTitle("loading", for: .normal)
           button.backgroundColor = UIColor(red: 122/255, green: 154/277, blue: 237/255, alpha: 1)
           button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
           button.layer.cornerRadius = 12
           return button
       }()

   

         var player:AVPlayer?
         var playerItem:AVPlayerItem?
         var playButton:UIButton?
    
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        

 
    }
 
 
    
    
    func check(name: String)  {
      
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            if let pathComponent = url.appendingPathComponent(name) {
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                print(pathComponent)
                if fileManager.fileExists(atPath: filePath) {
                    print(pathComponent)
//                    myVar.name += "copy"
//                    myVar.filename = myVar.name + myVar.format
                    self.buyButton.isHidden = true
                    print("FILE AVAILABLE")
                    self.isExist = true

                } else {
                    isExist = false
                    print("FILE NOT AVAILABLE")
                }
            } else {
                print("FILE PATH NOT AVAILABLE")
            }
            
        
    }
    

    @objc func playerDidFinishPlaying() {

                            playbutton.setTitle("play", for: .normal)
playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
                                            }
    
   
        
    @objc func downloadButton() {
        
        myVar.name = trackers?.name
        myVar.filename = (trackers?.id)! + myVar.name + myVar.format
        check(name: myVar.filename)
        
          while isExist == true {
            check(name: myVar.filename)
          }
        
              self.download()
        
          
      }
    
    
    
    
    
    
        
        func configurePlayButton() {
            
            guard let Songers = self.trackers else {return}
            
            Songers.checkIfSongIsBought { (bought) in
                
                if  bought {
                    
            
//
                    self.playbutton.setTitle("play", for: .normal)
//                    guard let main = self.trackers?.urlmain else {return}
//                             let trackmain = URL(string: main)
//                             let playerItem:AVPlayerItem = AVPlayerItem(url:trackmain!)
//                             self.player = AVPlayer(playerItem: playerItem)
//                             let playerLayer=AVPlayerLayer(player: self.player!)
//                             playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
//                             self.layer.addSublayer(playerLayer)
//
                    
        
                    
                }else{
                    self.playbutton.setTitle("demo", for: .normal)
                    guard let demo = self.trackers?.url else {return}
                   let trackdemo = URL(string: demo)
                   let playerItem:AVPlayerItem = AVPlayerItem(url:trackdemo!)
                   self.player = AVPlayer(playerItem: playerItem)
                   let playerLayer=AVPlayerLayer(player: self.player!)
                   playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
                   self.layer.addSublayer(playerLayer)
                                  
                }
                
            
            }
            
        }
    
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    

    
    let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        print(isExist)
        
        let destinationFileUrl = documentsUrl.appendingPathComponent(myVar.filename)


     do {
         
         
         try FileManager.default.copyItem(at: location, to: destinationFileUrl)

     } catch (let writeError) {
        
         print("******Error creating a file \(destinationFileUrl) : \(writeError)")
         myVar.name += "copy"

     }
    


       
   }
    
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            
            let percentDownloaded = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            
            
            
            
            // update the percentage label
            DispatchQueue.main.async {
                print(String(format: "%.0f%%", percentDownloaded * 100))
                self.numberDownload.text = String(format: "%.0f%%", percentDownloaded * 100)
                
                if percentDownloaded == 1 {
                    self.numberDownload.isHidden = true
                    self.buyButton.isHidden = true
                }

            }
        }

    
    

    
    func download() {
        

            
        let mainLink = (trackers?.urlmain)!
        let fileURL = URL(string: mainLink)
        let playerItem:AVPlayerItem = AVPlayerItem(url:fileURL!)
                   player = AVPlayer(playerItem: playerItem)
                   let playerLayer=AVPlayerLayer(player: player!)
                   playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
                   layer.addSublayer(playerLayer)
        // Create destination URL
    
        
        let sessionConfig = URLSessionConfiguration.default
        let operationQueue = OperationQueue()

        let session = URLSession(configuration: sessionConfig,delegate: self,delegateQueue: operationQueue)
        
        
        
        let task = session.downloadTask(with: fileURL!)
            
        
        
        //show the download has finished
        task.resume()

    }
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(playbutton)
        playbutton.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingtop: 10, paddingleft: 0, paddingbottom: 10, paddingright: 10, width: 50, height: 30)
        playbutton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        addSubview(buyButton)
        buyButton.anchor(top: playbutton.bottomAnchor, left: nil, bottom: nil, right: playbutton.leftAnchor, paddingtop: 10, paddingleft: 0, paddingbottom: 10, paddingright: 20, width: 30, height: 30)
        buyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


        addSubview(numberDownload)
        numberDownload.anchor(top: self.topAnchor, left: nil , bottom: nil, right: nil, paddingtop: 10, paddingleft: 10, paddingbottom: 10, paddingright: 50, width: numberDownload.frame.origin.x, height: numberDownload.frame.origin.y)
        numberDownload.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
      
//
//        addSubview(addtoPlaylist)
//        addtoPlaylist.anchor(top: self.topAnchor, left: textLabel?.rightAnchor , bottom: self.bottomAnchor , right: nil , paddingtop: 20, paddingleft: 10, paddingbottom: 20, paddingright: 0, width: 20, height: 20)
//        addtoPlaylist.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
////
            addSubview(lbl)
        lbl.anchor(top: self.topAnchor, left: nil , bottom: nil, right: numberDownload.leftAnchor, paddingtop: 10, paddingleft: 0, paddingbottom: 10, paddingright: 10, width: 80, height: 30)
        lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

     
        addSubview(img)
        img.anchor(top:nil, left: self.leftAnchor , bottom: nil , right: nil , paddingtop: 10, paddingleft: 5, paddingbottom: 0, paddingright: 0, width: 50, height: 50)
        img.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
        addSubview(addtoPlaylist)
                   addtoPlaylist.anchor(top: self.topAnchor, left: img.rightAnchor , bottom: nil, right: lbl.leftAnchor, paddingtop: 10, paddingleft: 2, paddingbottom: 10, paddingright: 5, width: addtoPlaylist.frame.origin.x, height: addtoPlaylist.frame.origin.y)
                   addtoPlaylist.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

             
        

        self.selectionStyle = .none
        
        
    }
    
    
    
    func configureBuyedButton() {
                    
                    guard let songs = self.trackers else {return}
                    
                    songs.checkIfSongIsBought { (isboght) in
                        
                        if isboght {
                            self.buyButton.tintColor = .black
                            self.buyButton.setImage(#imageLiteral(resourceName: "d"), for: .normal)
                            self.addtoPlaylist.isHidden = false
                            
                        }else{
                            self.numberDownload.isHidden = false
                           

                            self.buyButton.setTitle("buy", for: .normal)
                            self.buyButton.backgroundColor = UIColor(red: 122/255, green: 154/277, blue: 237/255, alpha: 1)
                            
                        }
                        
                        
                    }
                   
                }

    var ad = false
    
    @objc func buyButtonTapped() {
        
        
        
        guard let id = trackers?.id else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let trackname = trackers?.name else {return}
        
        print(id)
        
        print(trackname)
        print(buyButton.titleLabel?.text)

        if buyButton.titleLabel?.text == "buy" && ad == false {
            
        Database.database().reference().child("userOwnedAlbums").child(uid).child(id).updateChildValues([trackname : 1])
            buyButton.tintColor = .black
//            buyButton.setTitle("download", for: .normal)
            buyButton.backgroundColor = .none
            buyButton.setImage(#imageLiteral(resourceName: "d"), for: .normal)
            addtoPlaylist.isHidden = false
            numberDownload.isHidden = false
            buyButton.titleLabel?.text = ""
            ad = true
        }else{
            
            downloadButton()
            
        }
        
        
    }
    
     func downlo() {
        self.delegate2.downloadCompleted(for: self)
    }
    
    
    
    
   @objc func addButtonTapped() {
    
    idSong = trackers?.id
    
   self.delegate.addButtonTapped(for: self)
    
    
    

    
    }
    
    
    @objc func playButtonTapped() {
        
        idSong = trackers?.id
        songName = trackers?.name
      
        nameoftracks.myVar.name = trackers?.name
        nameoftracks.myVar.filename = idSong! + myVar.name + myVar.format
        
        self.delegate3.playButtonTapped(for: self)
        
    }

    

//    @objc func playButtonTapped(_ sender:UIButton)   {
//
//        myVar.filename = (trackers?.id)! + (trackers?.name)! + myVar.format
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//                  let url = NSURL(fileURLWithPath: path)
//        print(url)
//        if let pathComponent = url.appendingPathComponent(myVar.filename) {
//            print(pathComponent)
//                      let filePath = pathComponent.path
//                      let fileManager = FileManager.default
//
//
//            if (player?.rate == 0 || player?.rate == nil ) && ( playbutton.titleLabel?.text == "play" || playbutton.titleLabel?.text == "demo") {
//
//
//
//                     if fileManager.fileExists(atPath: filePath) {
//
//
//
//             let playerItem:AVPlayerItem = AVPlayerItem(url:pathComponent)
//                                         self.player = AVPlayer(playerItem: playerItem)
//                                         let playerLayer=AVPlayerLayer(player: self.player!)
//                                         playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
//                                         self.layer.addSublayer(playerLayer)
//
//
//
//
//
//
//              player!.play()
//              playbutton.setTitle("pause", for: .normal)
//              playbutton.backgroundColor = UIColor(displayP3Red: 235/255, green: 146/255, blue: 52/255, alpha: 1)
//                 //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
//
//                        print("0")
//
//                }
//
//
//             else{
//
//
//                           self.playbutton.setTitle("play", for: .normal)
//                           guard let main = self.trackers?.urlmain else {return}
//                           let trackmain = URL(string: main)
//                           let playerItem:AVPlayerItem = AVPlayerItem(url:trackmain!)
//                           self.player = AVPlayer(playerItem: playerItem)
//                           let playerLayer=AVPlayerLayer(player: self.player!)
//                           playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
//                           self.layer.addSublayer(playerLayer)
//
////                               if player?.rate == 0 && ( playbutton.titleLabel?.text == "play" ||
////                                playbutton.titleLabel?.text == "demo")
//
//                                   player!.play()
//                                   print("do")
//                                   playbutton.setTitle("pause", for: .normal)
//                                   playbutton.backgroundColor = UIColor(displayP3Red: 235/255, green: 146/255, blue: 52/255, alpha: 1)
//                                      //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
//                                    print("1")
//
////                                  } else {
////                                   player?.seek(to: CMTime.zero)
////                                   player?.pause()
////                                   playbutton.setTitle("play", for: .normal)
////                                   playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
////                                      //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
////                                  }
//
//                }
//                }
//
//            else{
//
//                player?.seek(to: CMTime.zero)
//                                     player?.pause()
//                                     playbutton.setTitle("play", for: .normal)
//                                     playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
//                                        //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
//
//                          print("2")
//            }
//
//        }
//
//       }
//

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 30, y: textLabel!.frame.origin.y - 2, width: (100), height: (textLabel?.frame.height)!)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        textLabel?.numberOfLines = 0
        
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
