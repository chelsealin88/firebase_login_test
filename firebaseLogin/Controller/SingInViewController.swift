//
//  SingInViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class SingInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var emailTextField: UITextField! 
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(selectedAvatar))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(singleTap)
    }
    
    @objc func selectedAvatar() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    // 會員註冊
    @IBAction func signButton(_ sender: Any) {
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
                print("form is not valid"); return }
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                // 成功註冊
                if error == nil {
                    print("you have successfully signed up")
                    let ref = Database.database().reference(fromURL: "https://logintest-ccce2.firebaseio.com/")
                    let uid = Auth.auth().currentUser?.uid
                    let value = ["name":name, "email":email]
                    // save user data
                    ref.child("user").child(uid!).setValue(value, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print(error)
                            return
                        } else {
                            self.dismiss(animated: true, completion: nil)
                            print("Saved user successfully into Firebase db")
                        }
                    })
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        avatarImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
}






