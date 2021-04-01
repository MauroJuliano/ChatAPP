//
//  StatusViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 31/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    private var statusRequest = StatusRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusRequest.getStatus(completionHandler: { success, _ in
            
        }
            
        )
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
