//
//  NewStatusViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 30/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class NewStatusViewController: UIViewController {

    @IBOutlet weak var barRight: UIView!
    @IBOutlet weak var barLeft: UIView!
    @IBOutlet weak var roundLeft: UIView!
    @IBOutlet weak var imageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
        // Do any additional setup after loading the view.
    }
    func cameraConfig() {

    }
    @IBAction func returnButtton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
