//
//  CustomChatsCollectionViewCell.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 09/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class CustomChatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconColor: RoundedView!
    
    func setup(colors: String){
        guard let otherColor = GradientColors(rawValue: colors) else {return}
               let gradientLayer = CAGradientLayer()
               gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
               gradientLayer.locations = [0.0 , 1.0]
               gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
               gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: iconColor.frame.size.width, height: iconColor.frame.size.height)
              
        iconColor.layer.insertSublayer(gradientLayer, below: iconColor.layer.sublayers?.last)
              
    }
}
