//
//  TabBarViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 23/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth
import BATabBarController

class TabBarViewController: UIViewController, BATabBarControllerDelegate {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
        print("delegate success!")
    }
    
    let tabController = BATabBarController()
  
    
    @IBOutlet weak var buttomView: RoundedView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var signInLabel: UILabel!
    
    //TextField
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        //set icons
        let tabBarItem = BATabBarItem(image: UIImage(named: "icons8-chat-room-100")!, selectedImage:  UIImage(named: "chatSelected")!)
        //icons8-chat-room-50
        let tabBarItem3 = BATabBarItem(image: UIImage(named: "icons8-settings-50")!, selectedImage:  UIImage(named: "settingsSelected")!)
        //icons8-settings-50
        
        guard let otherColor = GradientColors(rawValue: "miaka") else {return}
        let tabColor = UIColor(hexString: "EEEEEE")

        tabController.tabBarBackgroundColor = tabColor
        tabController.tabBarItemStrokeColor = UIColor(hexString: "B5338A")
        
        //set color icons
        tabBarItem.tintColor = UIColor.red
        tabBarItem3.tintColor = .red
        
        //inicialize controllers
        
    guard let vc1 = UIStoryboard(name: "Chats", bundle: nil).instantiateViewController(withIdentifier: "ChatNavigationController") as? UINavigationController else {return}
        
    guard let vc2 = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsNavigationController") as? UINavigationController else {return}

        tabController.delegate = self
        tabController.viewControllers = [vc1,vc2]
        tabController.tabBarItems = [tabBarItem,tabBarItem3]
        tabController.initialViewController = vc1
        self.view.addSubview(tabController.view)
    }
        // Do any additional setup after loading the view.
    }

