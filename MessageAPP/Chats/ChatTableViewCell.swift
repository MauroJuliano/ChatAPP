//
//  ChatTableViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher
class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var usuarioLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var usuarioImageView: UIImageView!
    @IBOutlet weak var timeMessageLabel: UILabel!
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(user: Friends){
        dateFormatter.dateFormat = "hh:mm a"
        usuarioLabel.text = user.name
        
        let epoc = Double(user.timeStamp)
        var epocTime = NSDate(timeIntervalSince1970: epoc ?? 0.0)
        let date = dateFormatter.string(from: epocTime as Date)
        
        lastMessageLabel.text = user.lastMessage
        timeMessageLabel.text = date
        let url = URL(string: user.image)
        usuarioImageView.kf.setImage(with: url)
        
        
    }
}
