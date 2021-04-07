//
//  EditProfilerViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 29/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditProfilerViewController: UIViewController {

    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextView!
    
    var users: [Users] = []
    private var controller: EditProfileViewControllerDelegate?
    private let db = Firestore.firestore()
    private var uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
         
        controller = EditProfileViewControllerDelegate(view: self)
        setup()
        // Do any additional setup after loading the view.
        

        
    }
    func setup() {
        for itens in users {
            nameTextField.text = itens.name
            bioTextView.text = itens.bio
            bioTextView.backgroundColor = UIColor(hexString: "EEEEEE")
            let url = URL(string: itens.image)
            editImageView.kf.setImage(with: url)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addTapped))
    }
    @objc func addTapped(){
        let user = db.collection("users").document(uid!).updateData([
            "name": nameTextField.text,
            "Bio": bioTextView.text])
    }
    @IBAction func chooseImageButton(_ sender: Any) {
        controller?.changePictureButtonTapped()
    }
    

}
