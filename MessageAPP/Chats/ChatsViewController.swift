//
//  ChatsViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 22/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

  
        @IBOutlet weak var topView: UIView!
        var controller: ChatTableViewDelegateDataSource?
        @IBOutlet weak var messageTableView: UITableView!
        var messagesArray = [User]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            controller = ChatTableViewDelegateDataSource(view: self)
            
            messageTableView.delegate = controller
            messageTableView.dataSource = controller
            
            setMessages()
            setupUI()
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
        
        func setMessages(){
            messagesArray.append(User(senderId: "other",
                                      image: "she",
                                      name: "Morrigan",
                                      lastMessage: "this is the end."))
            
            messagesArray.append(User(senderId: "other",
                                             image: "he",
                                             name: "Rhyss",
                                             lastMessage: "see you later."))
            messageTableView.reloadData()
        }
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = true
        }
        
    }

