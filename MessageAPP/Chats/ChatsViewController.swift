//
//  ChatsViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 22/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    private var timer: Timer?
        @IBOutlet weak var topView: UIView!
        private var userRequest = UserRequest()
        var controller: ChatTableViewDelegateDataSource?
        @IBOutlet weak var messageTableView: UITableView!
        var messagesArray = [User]()
        var chatArray = [Friends]()
        override func viewDidLoad() {
            getChats()
            super.viewDidLoad()
            
            controller = ChatTableViewDelegateDataSource(view: self)
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(getChats), userInfo: nil, repeats: true)
            
            messageTableView.delegate = controller
            messageTableView.dataSource = controller

            setupUI()
           
        }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func getChats() {
        userRequest.getUsers(completionHandler: { success, _ in
            if success {
                self.userRequest.getContato(completionHandler: { success, _ in
                    self.chatArray = self.userRequest.chatActive
                    self.messageTableView.reloadData()
                })
                
            }
        })
    }
    
    @IBAction func adicionarbutton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Friends", bundle: nil).instantiateViewController(withIdentifier: "FriendsNavigationController") as? UINavigationController {
        present(vc, animated: true, completion: nil)
        }
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
        }
        
    }

