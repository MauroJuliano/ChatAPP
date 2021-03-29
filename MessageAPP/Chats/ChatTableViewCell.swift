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
    var dateOutrange = NSDate(timeIntervalSinceNow: -604800) as Date
    
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
        var epocTime = NSDate(timeIntervalSince1970: epoc ?? 0.0) as Date
        let date = dateFormatter.string(from: epocTime)
        
        if Calendar.current.isDateInToday(epocTime) {
           timeMessageLabel.text = date
        }else if Calendar.current.isDateInYesterday(epocTime) {
            timeMessageLabel.text = "Yesterday"
        }else{
            if epocTime < dateOutrange {
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let daysAgo = dateFormatter.string(from: epocTime)
                 timeMessageLabel.text = daysAgo
            }else{
                dateFormatter.dateFormat = "EEEE"
            let week = dateFormatter.string(from: epocTime)
                timeMessageLabel.text = week
         }
        }
        lastMessageLabel.text = user.lastMessage
        
        let url = URL(string: user.image)
        usuarioImageView.kf.setImage(with: url)
    }
}
