//
//  StatusViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 31/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher
class StatusViewController: UIViewController{

    @IBOutlet weak var statusCollectionView: UICollectionView!


    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var nameLabel: UILabel!
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
    
        getStatus()
        //view.backgroundColor = .red
        setupUI()
    }
    
    func setupUI(){
        guard let otherColor = GradientColors(rawValue: "shroomhaze") else {return}
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewBack.frame.size.width, height: viewBack.frame.size.height)
        viewBack.layer.insertSublayer(gradientLayer, below: viewBack.layer.sublayers?.last)
    }
    
    func getStatus(){
        
        if let friendsStatus = friends {
            statusRequest.getStatus(ChildKey: friendsStatus.userID, completionHandler: { success, _ in
                if success {
                    self.status.append(contentsOf: self.statusRequest.statusArray)
                    self.setInfoStatus(image: friendsStatus.image, arrayCount: self.status.count)
                    self.statusCollectionView.reloadData()
                }
               
            }
         )
            
        } else if let currentStatus = user {
        statusRequest.getStatus(ChildKey: currentStatus.userID, completionHandler: { success, _ in
            if success {
                self.status.append(contentsOf: self.statusRequest.statusArray)
                self.setInfoStatus(image: currentStatus.image, arrayCount: self.status.count)
                self.statusCollectionView.reloadData()
                  }
             }
           )
        }
       
    }
    
    func setInfoStatus(image: String, arrayCount: Int){
        let url = URL(string:image)
        userImage.kf.setImage(with: url)
        
        if arrayCount == 1 {
            statusCollectionView.isScrollEnabled = false
        }
        self.pageControl.numberOfPages = arrayCount
    }

    @IBAction func returnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ButtonRight(_ sender: Any) {
       
    }
    
}
