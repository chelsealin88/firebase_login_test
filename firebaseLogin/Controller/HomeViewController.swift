//
//  HomeViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationBar()
        
        //user not loged in normally
        GetUserID()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func GetUserID() {
        let uid = Auth.auth().currentUser?.uid
        print("使用者UID:\(uid)")
        Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String : AnyObject] {
                self.navigationItem.title = value["name"] as? String
            }
        }
    }
    
    func settingNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogout))
        
    
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black


        
    }
    
    @objc func handleLogout() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                print("Log out successfully")
            } catch {
                print(error.localizedDescription)
            }
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
