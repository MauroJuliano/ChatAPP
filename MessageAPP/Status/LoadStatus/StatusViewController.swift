//
//  StatusViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 31/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController{

    @IBOutlet weak var statusCollectionView: UICollectionView!


    private var statusRequest = StatusRequest()
    var controller: StatusViewControllerDelegate?
    var friends: Friends?
    var user: Users?
    var status = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = StatusViewControllerDelegate(view: self)
        
        statusCollectionView.delegate = controller
        statusCollectionView.dataSource = controller
        
        //statusBar.delegate = self
        getStatus()
        //progressViewSetup()
        //progressView()
        // Do any additional setup after loading the view.
    }
    func getStatus(){
        
        if let friendsStatus = friends {
            statusRequest.getStatus(ChildKey: friendsStatus.userID, completionHandler: { success, _ in
                if success {
                    self.status.append(contentsOf: self.statusRequest.statusArray)
                    self.statusCollectionView.reloadData()
                }
               
            }
         )
            
        } else if let currentStatus = user {
        statusRequest.getStatus(ChildKey: currentStatus.userID, completionHandler: { success, _ in
            if success {
                self.status.append(contentsOf: self.statusRequest.statusArray)
                 self.statusCollectionView.reloadData()
                           }
                   }
                )
        }
    }
    @IBAction func returnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ButtonRight(_ sender: Any) {
       
    }
    
}
