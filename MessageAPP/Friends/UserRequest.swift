//
//  UserRequest.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth
class UserRequest {
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private var ref: DocumentReference? = nil
    private let databaseReference: DatabaseReference = Database.database().reference()
    private let uid = Auth.auth().currentUser?.uid
    
    var users: [Users] = []
    var friends: [Friends] = []
    var emailRequest: String?
    
    func getUsers(completionHandler: @escaping (_ result: Bool,_ result: Bool?) -> Void ){
        reference = db.collection("users")
        reference?.getDocuments { (querySnapshot, err) in
            if let err = err {
       
            }else {
                for document in querySnapshot!.documents {
                    
                if let name = document["name"] as? String,
                   let email = document["email"] as? String,
                   let userID = document["userID"] as? String,
                let image = document["imageProfile"] as? String{
                  
                    self.users.append(Users(userID: userID,
                                                       email: email,
                                                       name: name, image: image))
             }
         }
                completionHandler(true,nil)
      }
   }
  }
    
    func getContato(completionHandler: @escaping  (_ result: Bool,_ result: Bool?) -> Void) {
        let contact = db.collection("users").document(self.uid!).collection("contatos")
        contact.getDocuments { (querySnapshot, err) in
            if let err = err {
                
            }else {
                for document in querySnapshot!.documents {
                    if let chatID = document["chatID"] as? String,
                        let userID = document["userID"] as? String {
                        print(userID)
                        for itens in self.users {
                            if userID == itens.userID {
                                self.friends.append(Friends(userID: userID,
                                                            email: itens.email,
                                                            name: itens.name,
                                                            image: itens.image,
                                                            chatID: chatID))
                                
                                completionHandler(true, nil)
                            }
                        }
                       
                    }
                }
            }
        }
    }
}

