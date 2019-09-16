//
//  MessageTableViewCell.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/9/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var msgTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(_ chat: Chat) {
        msgTextView.text = chat.text
    }

}
