//
//  SingInViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SingInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.placeholder = "E-mail"
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.placeholder = "PassWord"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signButton(_ sender: Any) {
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                print("form is not valid"); return }
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                    print("you have successfully signed up")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
                    self.present(vc!, animated: true, completion: nil)
                    
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
}






