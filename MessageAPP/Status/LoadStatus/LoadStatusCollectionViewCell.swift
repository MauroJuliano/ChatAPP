//
//  StatusCollectionViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 01/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher

protocol ButtonCollectionView {
    func didButtonPressed()
}

class LoadStatusCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var buttonTapped : (() -> ()) = {}
    var leftButton : (() -> ()) = {}
    
    func setup(status: Status){
        let url = URL(string: status.image)
        imageView.kf.setImage(with: url)
    }
    
    @IBAction func rightButton(_ sender: Any) {
        leftButton()
    }
    @IBAction func leffButton(_ sender: Any) {
       buttonTapped()
    }
}
