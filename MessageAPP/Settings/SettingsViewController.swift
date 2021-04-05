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
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var borderView: RoundedView!
    @IBOutlet weak var bottomView: UIView!
    private var userRequest = UserRequest()
    private var controller: SettingsViewControllerDelegate?
    let uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.roundCorners(.bottomLeft, radius: 100)
        bottomView.roundCorners(.topRight, radius: 100)

        
        controller = SettingsViewControllerDelegate(view: self)
        
        settingsTableView.delegate = controller
        settingsTableView.dataSource = controller
        
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
               getUser()
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    func getUser(){
        userRequest.getUsers(completionHandler: { success, _ in
            if success {
                for itens in self.userRequest.users {
                    if self.uid == itens.userID {
                        self.setupUser(url: itens.image, name: itens.name, email: itens.email)
                        
                    }
                }
            }
        })
    }
    
    func setupUser(url: String, name: String, email: String){
        let url = URL(string: url)
        profileImage.kf.setImage(with: url)
        
        nameLabel.text = name
        emailLabel.text = email
    }
    
    func setupUI(){
       
            guard let otherColor = GradientColors(rawValue: "shroomhaze") else {return}
            let gradientLayer: CAGradientLayer = CAGradientLayer()
            
            gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
            gradientLayer.locations = [0.0 , 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: topView.frame.size.width, height: topView.frame.size.height)
        
       topView.layer.insertSublayer(gradientLayer, below: topView.layer.sublayers?.last)
        
        detailView.backgroundColor = otherColor.gradient.second
        borderView.backgroundColor = otherColor.gradient.first
        
//        let url = URL(string: "https://dwgyu36up6iuz.cloudfront.net/heru80fdn/image/upload/c_fill%2Cd_placeholder_thescene.jpg%2Cfl_progressive%2Cg_center%2Ch_360%2Cq_80%2Cw_640/v1524267747/glamour_celebrities-answer-what-was-the-lowest-amount-in-your-bank-account.jpg")
//        profileImage.kf.setImage(with: url)
        
        }
        
    @IBAction func logOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }


}
