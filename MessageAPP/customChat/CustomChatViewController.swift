//
//  CustomChatViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 09/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class CustomChatViewController: UIViewController {
    @IBOutlet weak var receiverChat: UIView!
    @IBOutlet weak var senderChat: UIView!
    @IBOutlet weak var backgroundChat: UIView!
    @IBOutlet weak var colors1CollectionView: UICollectionView!
    
    @IBOutlet weak var colors2CollectionView: UICollectionView!
    var controller: CustomChatsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Appearence"
        controller = CustomChatsViewControllerDelegate(view: self)
        receiverChat.roundCorners([.topRight, .topLeft, .bottomRight], radius: 15)
        senderChat.roundCorners([.bottomLeft, .topLeft, .bottomRight], radius: 15)
        
        backgroundChat.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper")!)
        
        colors1CollectionView.delegate = controller
        colors1CollectionView.dataSource = controller
        
        colors2CollectionView.delegate  = controller
        colors2CollectionView.dataSource = controller
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
