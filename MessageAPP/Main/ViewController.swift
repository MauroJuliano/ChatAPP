//
//  ViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        
        setupUI()
    }
    
    func setupUI(){
        topView.roundCorners(.bottomLeft, radius: 50)
        detailView.roundCorners(.topRight, radius: 40)
        
        guard let otherColor = GradientColors(rawValue: "dirtyFog") else {return}
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: topView.frame.size.width, height: topView.frame.size.height)
        
        topView.layer.insertSublayer(gradientLayer, below: topView.layer.sublayers?.last)
        backView.backgroundColor = otherColor.gradient.second
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Chats", bundle: nil).instantiateInitialViewController() as? ChatsViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
  
}
