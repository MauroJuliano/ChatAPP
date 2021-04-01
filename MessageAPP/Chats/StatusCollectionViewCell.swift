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
    @IBOutlet weak var statusBorder: RoundedView!
    
    func setup(friends: Friends){
        let url = URL(string: friends.image)
        statusImage.kf.setImage(with: url)
        
        guard let otherColor = GradientColors(rawValue: "kashmir") else {return}
        let gradientLayer: CAGradientLayer = CAGradientLayer()
                   
       gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
       gradientLayer.locations = [0.0 , 1.0]
       gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
       gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
       gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: statusBorder.frame.size.width, height: statusBorder.frame.size.height)
        statusBorder.layer.insertSublayer(gradientLayer, below: statusBorder.layer.sublayers?.last)
    }
    
}
