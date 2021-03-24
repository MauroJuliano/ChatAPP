//
//  FriendsViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth
class FriendsViewController: UIViewController {

    @IBOutlet weak var friendsTableView: UITableView!
    
    
    var controller: FriendsViewControllerDelegate?
    private var userRequest: UserRequest?
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private var ref: DocumentReference? = nil
    private let uid = Auth.auth().currentUser?.uid
    private let databaseReference: DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        userRequest = UserRequest()
        controller = FriendsViewControllerDelegate(view: self)
        friendsTableView.delegate = controller
        friendsTableView.dataSource = controller
        
        floatingSetup()
        // Do any additional setup after loading the view.
    }
    
    private func floatingSetup(){
        let actionButton = JJFloatingActionButton()
        
        actionButton.addItem(title: "New Group",image: UIImage(systemName: "person.3.fill")?.withRenderingMode(.alwaysOriginal)) { item in
            try! Auth.auth().signOut()
            //self.addNewContact(title: "New Group", content: "Enter name of this group")
        }
        
        actionButton.addItem(title: "New Contact",image: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal)) { item in
            self.addNewContact(title: "New Contact", content: "Enter email to add new contact")
        }

        view.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        
          guard let otherColor = GradientColors(rawValue: "pinky") else {return}
          actionButton.buttonColor = otherColor.gradient.first

    }
    
    func addNewContact(title: String, content: String){
        let ac = UIAlertController(title: title, message: content, preferredStyle: .alert)
        
        ac.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter second name"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = ac.textFields![0] as UITextField
            self.save(emailRequest: textField.text  ?? "")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { alert -> Void in
            
        })
        
        ac.addAction(cancelAction)
        ac.addAction(saveAction)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func save(emailRequest: String){
        
        userRequest?.getUsers(completionHandler: {name, email, userID in
            if emailRequest == email {
                print("teste retorno")
               self.saveTo(userID: userID)
                //create a new channel
            }
        })
    }
    
    func saveTo(userID: String){
        print(userID)
        
            //create a new channel
            let messageId = self.databaseReference.childByAutoId()


            //create contacts
            let dict: [String: Any] = [
                "userID": "\(self.uid)",
                "chatID": "\(messageId)"
            ]

            let currentDict: [String: Any] = [
                "userID": userID,
                "chatID": "\(messageId)"
            ]
        let channels = db.collection("channels").document("\(messageId)").collection("thread")
        channels.addDocument(data: dict)
        
//            self.ref = self.db.collection("channels").addDocument(data: [
//                "userID": userID,
//                 "chatID": "\(messageId)"
//            ])
//            self.databaseReference.child("users").child(userID).child("contatos").child(self.uid!).updateChildValues(dict)
//            self.databaseReference.child("users").child(self.uid!).child("contatos").child(userID).updateChildValues(currentDict)

        self.dismiss(animated: true, completion: nil)
        return
        }
}
