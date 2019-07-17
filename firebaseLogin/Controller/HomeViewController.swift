//
//  HomeViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        print("Log out")
    }
    
//    @IBAction func logoutButton(_ sender: Any) {
//        if Auth.auth().currentUser != nil {
//            do {
//                try Auth.auth().signOut()
//                let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! LoginViewController
//                present(vc, animated: true, completion: nil)
//                print("log out successfully")
//            } catch let error as NSError {
//                print(error.localizedDescription)
//                
//            }
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
