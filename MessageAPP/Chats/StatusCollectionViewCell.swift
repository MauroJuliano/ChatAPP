//
//  StatusCollectionViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 30/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher
class StatusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var statusImage: UIImageView!
    
    func setup(friends: Friends){
        let url = URL(string: friends.image)
        print(url)
        statusImage.kf.setImage(with: url)
    }
    
}
