//
//  settingsTableViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 25/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class settingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var cellView: RoundedView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var roundedImage: RoundedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func roundeCell(){
        cellView.roundCorners(.allCorners, radius: 30)
    }
}
