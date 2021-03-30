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
    
    var delegate: HeaderDelegate?
    func selectCell(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    @objc func headerViewTapped(){
        delegate?.doSomething()
    }
    func setup(user: Users){
        let url = URL(string: user.image)
        statusImageView.kf.setImage(with: url)
    }
}
