//
//  ChatViewController.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/9/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    enum CellID: String {
        case owner = "MessageTableViewCell"
        case user = "UserMessageTableViewCell"
    }
    
    var chats = [Chat]()
    var user : User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadChatRoom()
    }
    
    func loadChatRoom() {
        
   
//        self.ref.child("Chat").queryOrdered(byChild: "postDate").observe(.value) { (snapShot) in
//            self.chats.removeAll()
//            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
//                for snap in snapShot {
//
//                    if let chatData = snap.value as? [String:AnyObject] {
//
//                        let userName = chatData["name"] as? String
//                        let text = chatData["text"] as? String
//
//                        var postDate: CLong?
//                        if let postDateIn = chatData["postDate"] as? CLong {
//                            postDate = postDateIn
//
//                        }
//                        self.chats.append(Chat(userName: userName, text: text, date: "\(postDate)"))
//                    }
//
//                }
//                self.tableView.reloadData()
//            }
//        }
    }

    @IBAction func sendBtn(_ sender: Any) {
        let ref = Database.database().reference().child("Chat")
        let toId = user!.id
        let values = ["text": textField.text, "toId" : toId ]
        let childRef = ref.childByAutoId()
        childRef.updateChildValues(values)
    }
}



extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.owner.rawValue, for: indexPath) as! MessageTableViewCell
        cell.updateCell(chats[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
