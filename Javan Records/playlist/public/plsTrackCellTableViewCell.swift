//
//  plsTrackCellTableViewCell.swift
//  Javan Records
//
//  Created by Hesamoddin on 10/9/1399 AP.
//  Copyright © 1399 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation



struct myVars {
    
    static var name:String!
    static var format = ".mp3"
    static var filename = myVars.name + myVars.format

}



class plsTrackCellTableViewCell: UITableViewCell,URLSessionDownloadDelegate {
    
    

         var player:AVPlayer?
         var playerItem:AVPlayerItem?
         var playButton:UIButton?
    
    
    var delegate2 : dones!
    var delegate : what2!
    
   
    
    
    
      func pause(for cell : tracksTableViewCell) {

          player?.seek(to: CMTime.zero)
          player?.pause()
          cell.playbutton.setTitle("play", for: .normal)
          cell.playbutton.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
          
      }
      
    
    
    
    var albumname : String?
    var isExist = true
   
    var this: whatname?

    var trackers:Song?{
        didSet{
            
            let idSong = trackers?.id
            let nameSong = trackers?.name
            let urlDemoSong = trackers?.url
            let urlSong = trackers?.urlmain
            myVars.name = trackers?.name
                       myVars.filename = idSong! + myVars.name + myVars.format
            print(myVars.filename)
                       check(name: myVars.filename)
                   
            self.textLabel?.text = nameSong
            
        }
    }
    
    
  
       
       
       

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
           button.setTitle("download", for: .normal)
           button.backgroundColor = UIColor(red: 122/255, green: 154/277, blue: 237/255, alpha: 1)
           button.addTarget(self, action: #selector(downloadButton), for: .touchUpInside)
           button.layer.cornerRadius = 12
           return button
       }()
    
    
       
       

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    
    
        
         func check(name: String)  {
              
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                print(name)
                    let url = NSURL(fileURLWithPath: path)
                    if let pathComponent = url.appendingPathComponent(name) {
                        let filePath = pathComponent.path
                        let fileManager = FileManager.default
                        print(pathComponent)
                        if fileManager.fileExists(atPath: filePath) {
                            print("EXIIIIIIIISSSSSSTTTTTTTTTTT")
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
                
                myVars.name = trackers?.name
                myVars.filename = (trackers?.id)! + myVars.name + myVars.format
                check(name: myVars.filename)
                
                  while isExist == true {
                    check(name: myVars.filename)
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
                 
                 let destinationFileUrl = documentsUrl.appendingPathComponent(myVars.filename)


              do {
                  
                  
                  try FileManager.default.copyItem(at: location, to: destinationFileUrl)

              } catch (let writeError) {
                 
                  print("******Error creating a file \(destinationFileUrl) : \(writeError)")
                  myVars.name += "copy"

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
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .value1, reuseIdentifier: reuseIdentifier)
            
            
            
            addSubview(playbutton)
            playbutton.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingtop: 10, paddingleft: 0, paddingbottom: 10, paddingright: 10, width: 80, height: 30)
            playbutton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            addSubview(buyButton)
            buyButton.anchor(top: self.topAnchor, left: nil, bottom: nil, right: playbutton.leftAnchor, paddingtop: 10, paddingleft: 0, paddingbottom: 10, paddingright: 20, width: 80, height: 30)
            buyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


            addSubview(numberDownload)
            numberDownload.anchor(top: self.topAnchor, left: nil, bottom: nil, right: buyButton.leftAnchor, paddingtop: 0, paddingleft: 20, paddingbottom: 0, paddingright: 30, width: numberDownload.frame.origin.x, height: numberDownload.frame.origin.y)
            numberDownload.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
       

            self.selectionStyle = .none
            
            
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
       
       func downlo() {
              self.delegate2.downloadCompleted(for: self)
          }
        
        
        func configureBuyedButton() {
                        
                        guard let songs = self.trackers else {return}
                        
                        songs.checkIfSongIsBought { (isboght) in
                            
                            if isboght {
                                
                                self.numberDownload.isHidden = true
                                self.buyButton.setTitle("download", for: .normal)
                                
                            }else{
                                self.numberDownload.isHidden = false
                                self.buyButton.setTitle("buy", for: .normal)
                                
                            }
                            
                            
                        }
                       
                    }

        
    
    
    
        
        @objc func buyButtonTapped() {
            
            
            
            guard let id = trackers?.id else {return}
            guard let uid = Auth.auth().currentUser?.uid else {return}
            guard let trackname = trackers?.name else {return}
            
            print(id)
            
            print(trackname)
            
            if buyButton.titleLabel?.text == "buy" {
                
            Database.database().reference().child("userOwnedAlbums").child(uid).child(id).updateChildValues([trackname : 1])
                
                buyButton.setTitle("download", for: .normal)
                
                numberDownload.isHidden = true
            
            
            }else{
                
                downloadButton()
                
            }
            
            
        }

        @objc func playButtonTapped() {
             
             idSong = trackers?.id
             songName = trackers?.name
           
             plsTracks.myVar.name = trackers?.name
             plsTracks.myVar.filename = idSong! + myVars.name + myVars.format
             
             self.delegate.playButtonTapped(for: self)
             
         }
        

        
        
        
        
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            textLabel?.frame = CGRect(x: 30, y: textLabel!.frame.origin.y - 2, width: (100), height: (textLabel?.frame.height)!)
            textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            textLabel?.numberOfLines = 0
            
            
            
        }

        
       

    }



