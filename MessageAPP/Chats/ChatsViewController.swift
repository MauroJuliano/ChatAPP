//
//  ChatsViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 22/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
        @IBOutlet weak var topView: UIView!
        @IBOutlet weak var messageTableView: UITableView!
        @IBOutlet weak var leftConstraints: NSLayoutConstraint!
        private var userRequest: UserRequest?
        var controller: ChatTableViewDelegateDataSource?

        private var shouldCollapse = true
    
        var messagesArray = [User]()
        var chatArray = [Friends]()
    
    var buttonSearch: Bool {
        return shouldCollapse ? true : false
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            leftConstraints.constant = CGFloat(300)
            
            controller = ChatTableViewDelegateDataSource(view: self)
           
            messageTableView.delegate = controller
            messageTableView.dataSource = controller
            searchBar.delegate = controller
            
            setupUI()
          
           
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        userRequest = UserRequest()
        getChats()
    }
    
    @objc func getChats() {
        userRequest?.getUsers(completionHandler: { success, _ in
            if success {
                self.userRequest?.getContato(completionHandler: { success, _ in
                    if success {
                        self.chatArray.removeAll()
                        self.chatArray.append(contentsOf: self.userRequest!.chatActive)
                        
                        self.messageTableView.reloadData()
                    }
                
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
    
    @IBAction func filterButton(_ sender: Any) {
        if shouldCollapse {
            animateView(isCollapse: false, widthConstraint: 26)
        }else {
            animateView(isCollapse: true, widthConstraint: 300)
        }
    }
    
    private func animateView(isCollapse: Bool,
                             widthConstraint: Double) {
        shouldCollapse = isCollapse
        leftConstraints.constant = CGFloat(widthConstraint)
        UIView.animate(withDuration: 1){
            self.view.layoutIfNeeded()
        }
    }
}
