//
//  StatusCollectionReusableView.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 30/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher
protocol HeaderDelegate {
    func doSomething()
}
class StatusCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusBorder: RoundedView!
    
    var buttonTapped: (() -> ()) = {}
    
    var delegate: HeaderDelegate?
    func selectCell(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    @objc func headerViewTapped(){
        delegate?.doSomething()
    }
    @IBAction func cellTapped(_ sender: Any) {
        buttonTapped()
    }
    func setup(user: Users){
        let url = URL(string: user.image)
        statusImageView.kf.setImage(with: url)
        
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
