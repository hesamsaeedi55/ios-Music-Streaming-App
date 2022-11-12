//
//  SignupVC.swift
//  InstagramCopy
//
//  Created by Hesamoddin on 9/23/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import UIKit
import Firebase



class SignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imageSelected = false
    
    
    let plusbutton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ch").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleprofilephoto), for: .touchUpInside)
        return button
    }()
    
    let Emailtextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let passwordtextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    
    let fullnametextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "fullname"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        return tf
    }()
    
    
    let usernametextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        return tf
    }()
    
    let Signupbutton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
        
        
    }()
    
    let alreadyhaveanaccount: UIButton = {
        
        let button = UIButton(type: .system)
        let attribiuted = NSMutableAttributedString(string: "already have an account?   ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attribiuted.append(NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleshowsignin), for: .touchUpInside)
        button.setAttributedTitle(attribiuted, for: .normal)
        return button
        
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen

        view.backgroundColor = .white
        view.addSubview(plusbutton)
        plusbutton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingtop: 40, paddingleft: 0, paddingbottom: 0, paddingright: 0, width: 140, height: 140)
        plusbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        configureviewcontroller()
        view.addSubview(alreadyhaveanaccount)
        alreadyhaveanaccount.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingtop: 0, paddingleft: 0, paddingbottom: 0, paddingright: 0, width: 0, height: 50)
        
        
          
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)

        
    }
    
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //selected image
        guard let profileimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        
        //configure button with photo
        imageSelected = true
        plusbutton.layer.cornerRadius = plusbutton.frame.width / 2
        plusbutton.layer.masksToBounds = true
        plusbutton.layer.borderColor = UIColor.black.cgColor
        plusbutton.layer.borderWidth = 2
        plusbutton.setImage(profileimage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @objc func handleprofilephoto() {
        let imgpicker = UIImagePickerController()
        imgpicker.delegate = self
        imgpicker.allowsEditing = true
        self.present(imgpicker, animated: true, completion: nil)
    }
    
    
    
    
    
    @objc func formValidation() {
        guard
            Emailtextfield.hasText,
            passwordtextfield.hasText,
            usernametextfield.hasText,
            fullnametextfield.hasText,
            imageSelected == true
            else {
                
                Signupbutton.isEnabled = false
                Signupbutton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                return
        }
        Signupbutton.isEnabled = true
        Signupbutton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    
    
    
    
    
    
    
    @objc func handleSignUp() {
        
        // properties for input values that we need to create users
        guard let email = Emailtextfield.text else { return }
        guard let password = passwordtextfield.text else { return }
        guard let fullName = fullnametextfield.text else { return }
        guard let username = usernametextfield.text?.lowercased() else { return }
        
        //function create user wwith email and password
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            // handle error
            if let error = error {
                print("DEBUG: Failed to create user with error: ", error.localizedDescription)
                return
            }
            
            
            
            
            //set profile image
            guard let profileImg = self.plusbutton.imageView?.image else { return }
            
            
            
            
            //upload data for profile image
            guard let uploadData = profileImg.jpegData(compressionQuality: 0.3) else { return }
            
            
            
            
            //place image in firebase storage
            let filename = NSUUID().uuidString
            
            // UPDATE: - In order to get download URL must add filename to storage ref like this and "profile_images" new folder that created in database
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                
                
                
                
                // handle error for image upload
                if let error = error {
                    print(" oad image to Firebase Storage with error", error.localizedDescription)
                    return
                }
                
                
                // UPDATE: - Firebase 5 must now retrieve download url ------ profile image URL
                storageRef.downloadURL(completion: { (downloadURL, error) in
                    
                    guard let profileImageUrl = downloadURL?.absoluteString else {
                        print("DEBUG: Profile image url is nil")
                        return
                    }
                    
                    // user id
                    guard let uid = authResult?.user.uid else { return }
                    
                    //attribiutes of user
                    let dictionaryValues = ["name": fullName,
                                            "username": username,
                                            "profileImageUrl": profileImageUrl
                                            ]
                    
                    
                    
                    
                    
                    //updating users
                    let values = [uid: dictionaryValues]
                    
                    
                    
                    // save user info to database
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                        
//                        guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else {return}
//                        
//                        //configure view controller in maintabvc
//                        mainTabVC.configureViewController()
//                        
                        //dismiss login controller
                        self.dismiss(animated: true, completion: nil)
                        
                        
                        
                    })
                    
                    
                    
                    
                })
            })
        }
    }
    
    
    
    
    
    
    @objc func handleshowsignin() {
        let signin = LoginVC()
        signin.modalPresentationStyle = UIModalPresentationStyle(rawValue: 0)!
        present(signin, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func configureviewcontroller() {
        
        let StackView = UIStackView(arrangedSubviews: [Emailtextfield,fullnametextfield,usernametextfield,passwordtextfield,Signupbutton])
        StackView.axis = .vertical
        StackView.spacing = 10
        StackView.distribution = .fillEqually
        view.addSubview(StackView)
        StackView.anchor(top: plusbutton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingtop: 40, paddingleft: 40, paddingbottom: 0, paddingright: 40  , width: 0, height: 240)
        
    }
    
}


