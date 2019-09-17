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
    
    var chats = [Chat]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        
        //user not loged in normally
        GetUserID()
        observeMsg()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func observeMsg() {
        
        let ref = Database.database().reference().child("Chat")
        ref.observe(.childAdded, with: { (snapshot) in
            
//            print(snapshot)
            if let dic = snapshot.value as? [String:AnyObject] {
                
                let chat = Chat()
                chat.setValuesForKeys(dic)
                print(chat.text)
            }
            
            
            

    }, withCancel: nil)
    
    
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
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Mail", style: .plain, target: self, action: #selector(handleNewMessage))
    
    var navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = .black
    
    //        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
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

@objc func handleNewMessage() {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "NewMassagesTableViewController") as! NewMassagesTableViewController
    navigationController?.pushViewController(vc, animated: true)
    
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


extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = chats[indexPath.row].text
        return cell
    }
    
    
    
}
