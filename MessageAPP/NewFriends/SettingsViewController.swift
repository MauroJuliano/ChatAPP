//
//  NewFriendViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import FirebaseAuth
class SettingsViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var borderView: RoundedView!
    private var controller: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        controller = SettingsViewControllerDelegate(view: self)
        
        settingsTableView.delegate = controller
        settingsTableView.dataSource = controller
        
        setupUI()
        

        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
            guard let otherColor = GradientColors(rawValue: "shroomhaze") else {return}
            let gradientLayer: CAGradientLayer = CAGradientLayer()
            
            gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
            gradientLayer.locations = [0.0 , 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradientLayer, below: self.view.layer.sublayers?.last)
        borderView.backgroundColor = otherColor.gradient.first
        
        let url = URL(string: "https://dwgyu36up6iuz.cloudfront.net/heru80fdn/image/upload/c_fill%2Cd_placeholder_thescene.jpg%2Cfl_progressive%2Cg_center%2Ch_360%2Cq_80%2Cw_640/v1524267747/glamour_celebrities-answer-what-was-the-lowest-amount-in-your-bank-account.jpg")
        profileImage.kf.setImage(with: url)
        
        }
        
    @IBAction func logOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }


}
