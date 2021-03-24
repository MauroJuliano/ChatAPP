//
//  RegisterViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 23/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class RegisterViewControllerDelegate {
    weak var view: RegisterViewController?
    let ref: DatabaseReference = Database.database().reference()
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private var uid: String? { Auth.auth().currentUser?.uid }
    
    init(view: RegisterViewController){
        self.view = view
    }
    
    func createUser(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        
        //get data from textfield and check if is empty
        
        guard let name = view?.nameTextField.text,
            let email = view?.emailTextField.text ,
            let password = view?.passwordTextField.text,
            let reenter = view?.reentryPasswordTextField.text,
            !name.isEmpty, !email.isEmpty, !password.isEmpty, !reenter.isEmpty else {return}

          guard password == reenter else { return }
        
          Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            guard error == nil else { return }
            
            self.saveData(email: email, name: name, completionHandler: { success, _ in
                if success {
                    completionHandler(true,nil)
                }
            })
         })
    }
    
    func saveData(email: String,name: String, completionHandler: @escaping (_ result: Bool, _ error: Bool?) -> Void){
        
        let dict: [String: Any] = [
            "name": name,
            "email": email,
            "userID": uid
        ]
        let userRef = db.collection("users")
        if let user = uid {
            userRef.document("\(uid!)").setData([
                
                "name": name,
                "email": email,
                "userID": user
            ])
    
            completionHandler(true,nil)
        }        
    }
}

