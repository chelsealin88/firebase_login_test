//
//  ViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButton(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your E-mail or  PassWord", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                print("form is not valid"); return }
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    print("you have successfully login")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                    self.present(vc!, animated: true, completion: nil)
                }
                
            }
        }
    }
    

}
