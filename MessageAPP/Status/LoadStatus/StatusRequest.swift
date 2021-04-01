//
//  StatusRequest.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 31/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class Status {
    var image: String
    var timeStamp: Double
    var user: String
    
    init(image: String, timeStamp: Double, user: String) {
        self.image = image
        self.timeStamp = timeStamp
        self.user = user
    }
    
    
}

class StatusRequest {
    private var reference: CollectionReference?
    private let db = Firestore.firestore()
    var statusArray = [Status]()
    
    func getStatus(ChildKey: String, completionHandler: @escaping (_ result: Bool,_ error: Bool?) -> Void){
        
        reference = db.collection("stories")
        reference?.getDocuments { (querySnapshot, err) in
            if let err = err {
                
            }else{
                for document in querySnapshot!.documents {
                
                    if let userID = document["userID"] as? String,
                       let statusImage = document["statusImage"] as? String,
                        let timeStamp = document["TimeStamp"] as? Double {
                        
                        if userID == ChildKey {
                            self.statusArray.append(Status(image: statusImage,
                                                            timeStamp: timeStamp,
                                                            user: userID))
                        }
                    }
                }
                completionHandler(true,nil)
            }
        }
    }
}
