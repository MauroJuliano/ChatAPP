//
//  StatusCollectionViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 01/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher
class LoadStatusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(status: Status){
        let url = URL(string: status.image)
        imageView.kf.setImage(with: url)
    }
}
