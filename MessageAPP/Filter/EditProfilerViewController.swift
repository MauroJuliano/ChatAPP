//
//  EditProfilerViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 29/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class EditProfilerViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var filterSearchBar: UISearchBar!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var editImageView: UIImageView!
    private var controller: EditProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
         
        controller = EditProfileViewControllerDelegate(view: self)
        // Do any additional setup after loading the view.
    }
    @IBAction func chooseImageButton(_ sender: Any) {
        controller?.changePictureButtonTapped()
    }
    

}
