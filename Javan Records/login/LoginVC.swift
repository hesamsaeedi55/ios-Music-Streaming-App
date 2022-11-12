//
//  SignIn.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/18/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import LocalAuthentication


class LoginVC: UIViewController {
    
    var player : AVPlayer?
    var albums = [String]()
 
    lazy var img : CustomImageView = {
         let photo = CustomImageView()
        photo.image = UIImage(named: "2222")
         photo.contentMode = .scaleAspectFill
         photo.clipsToBounds = true
         photo.backgroundColor = .black
        photo.isHidden = true
         photo.layer.cornerRadius = 10
         return photo
     }()
     
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login", for: .normal)
        button.backgroundColor = UIColor (red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(logInhandle), for: .touchUpInside)
        return button
    }()


    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(string: "email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        text.font = UIFont.systemFont(ofSize: 14)
        text.layer.borderColor = UIColor(ciColor: .white).cgColor
        text.layer.borderWidth = 2
        text.layer.cornerRadius = 10
        text.font = UIFont.systemFont(ofSize: 12)
        let color : UIColor = UIColor(red: 25/255, green: 132/255, blue: 183/255, alpha: 1)
        text.textColor = .black
        text.textAlignment = .center
        text.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        text.addTarget(self, action: #selector(validation), for: .editingChanged)
        return text
      
    }()
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor(white: 1, alpha: 0.04)
        text.attributedPlaceholder = NSAttributedString(string: "password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        text.font = UIFont.systemFont(ofSize: 14)
        text.layer.borderColor = UIColor(ciColor: .white).cgColor
        text.layer.borderWidth = 2
        text.layer.cornerRadius = 10
        text.font = UIFont.systemFont(ofSize: 12)
        let color : UIColor = UIColor(red: 25/255, green: 132/255, blue: 183/255, alpha: 1)
        text.textColor = .black
        text.isSecureTextEntry = true
        text.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        text.addTarget(self, action: #selector(validation), for: .editingChanged)
        text.textAlignment = .center
        return text
    }()
    
    let touchId : UIButton = {
          let button = UIButton(type: .system)
          let attributed = NSMutableAttributedString(string: "برای ورود با اثر انگشت کلید مقابل را لمس کنید   ", attributes:  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),NSAttributedString.Key.foregroundColor:UIColor.black])
          attributed.append(NSAttributedString(string: "ورود با اثر انگشت", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),NSAttributedString.Key.foregroundColor:UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
          button.setAttributedTitle(attributed, for: .normal)
          button.addTarget(self, action: #selector(tog), for: .touchUpInside)
          return button
      }()
    
    let donthaveanaccount : UIButton = {
        let button = UIButton(type: .system)
        let attributed = NSMutableAttributedString(string: "don't have an account?   ", attributes:  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        attributed.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.setAttributedTitle(attributed, for: .normal)
        button.addTarget(self, action: #selector(handleshowsignup), for: .touchUpInside)
        return button
    }()
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @objc func tog() {
        img.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playbackground()
        
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
            
        }
    
        view.backgroundColor = .black
 
        view.addSubview(donthaveanaccount)
        donthaveanaccount.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingtop: 0, paddingleft: 0, paddingbottom: 20, paddingright: 0, width: 0, height: 50)
        
        view.addSubview(touchId)
        touchId.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingtop: 350, paddingleft: 0, paddingbottom: 20, paddingright: 0, width: 0, height: 50)
        
        view.addSubview(img)
        img.anchor(top: touchId.bottomAnchor, left: nil, bottom: nil, right: nil, paddingtop: 20, paddingleft: 0, paddingbottom: 0, paddingright: 0, width: 60, height: 60)
        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        configureViewController()
        
        
       
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.navigationController?.pushViewController(genreVC(), animated: true)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    @objc func handleshowsignup() {
       
        let signupvc = SignUpVC()
        navigationController?.pushViewController(signupvc, animated: true)
        print("done")
        
        
        
    }
    
    
    
    
    
    func configureViewController() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,logInButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingtop: 150, paddingleft: 95, paddingbottom: 0, paddingright: 95, width: 0, height: 110)
        
    }
    
    
    
    
    @objc func logInhandle() {
        
        // properties
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        // sign user in with email and password
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            // handle error
            if let error = error {
                print("Unable to sign user in with error", error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: nil)

            MainTabVC().modalPresentationStyle = .fullScreen
            self.present(MainTabVC(),animated:true)
        }
        
    }
    
    func playbackground() {
        let path = Bundle.main.path(forResource: "this", ofType: ".mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerlayer = AVPlayerLayer(player: player)
        playerlayer.frame = self.view.frame
        playerlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerlayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerLayerItemReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerLayerItemReachEnd() {
        player?.seek(to: CMTime.zero)
    }
    
    
    
    @objc func validation() {
        guard
            emailTextField.hasText,
            passwordTextField.hasText else {
                
                logInButton.isEnabled = false
             
                return
        }
        logInButton.isEnabled = true
        
             logInButton.backgroundColor = UIColor(red: 203/255, green: 109/255, blue: 122/255, alpha: 1)
        
        print("true")
    }

    
    }


