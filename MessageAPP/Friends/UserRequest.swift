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
class UserRequest {
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private var ref: DocumentReference? = nil
    private let databaseReference: DatabaseReference = Database.database().reference()
    
    var users: [Users] = []

    var nameUser: String = ""
    var emailUser: String = ""
    var idUser: String = ""

    func getUsers(completionHandler: @escaping (_ name: String,_ email: String,_ userID: String) -> Void ){
        reference = db.collection("users")
        reference?.getDocuments { (querySnapshot, err) in
            if let err = err {
       
            }else {
                for document in querySnapshot!.documents {
                    
                if let name = document["name"] as? String,
                let email = document["email"] as? String,
                let userID = document["userID"] as? String{
                    
                 self.users.append(Users(userID: userID,
                                          email: email,
                                          name: name))
                    
                    self.nameUser = name
                    self.emailUser = email
                    self.idUser = userID
              
             }
         }
                completionHandler(self.nameUser,self.emailUser,self.idUser)
     }
 }
}
}

