//
//  NewMassagesTableViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/18.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewMassagesTableViewController: UITableViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewMassagesTableViewCell
        let user = users[indexPath.row]
        cell.updateCell(user)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        let user = users[indexPath.row]
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
        
    }

    
    func fetchUser() {
        
        Database.database().reference().child("user").observe(.childAdded) { (snapshot) in
            
            var user = User()
            user.emial = (snapshot.value as? NSDictionary)?["email"] as? String ?? ""
            user.name = (snapshot.value as? NSDictionary)?["name"] as? String ?? ""
            user.id = snapshot.key
            self.users.append(user)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


}
