//
//  FriendsTableViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(friend: Friends){
        nameLabel.text = friend.name
        captionLabel.text = friend.bio
        let url = URL(string: friend.image)
        profileImage.kf.setImage(with: url)
    }
}
