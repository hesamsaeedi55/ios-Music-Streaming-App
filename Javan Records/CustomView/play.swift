import UIKit
import AVFoundation

class ViewController: UIViewController  {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    
    
    
    lazy var playbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("play", for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/277, blue: 237/255, alpha: 1)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 400, width: 20, height: 20)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/javan-b82d7.appspot.com/o/cigar.mp3?alt=media&token=94a9eaaa-b324-4b39-8167-688fefe4331c")
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        
        
        
        
        
        self.view.addSubview(playbutton)
    }
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playbutton.setTitle("Pause", for: UIControl.State.normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playbutton.setTitle("Play", for: UIControl.State.normal)
        }
    }
    
}
