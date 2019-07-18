//
//  NewMassagesTableViewCell.swift
//  firebaseLogin
//
//  Created by Chelsea Lin on 2019/7/18.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class NewMassagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLebal: UILabel!
    @IBOutlet weak var emailLebel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = 40
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(_ user: User) {
        nameLebal.text = user.name
        emailLebel.text = user.emial
    }

}
