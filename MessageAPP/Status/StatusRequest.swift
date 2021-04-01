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
struct Status {
    var image: String
    var timeStamp: Double
    var user: String
    
}

class StatusRequest {
    private var reference: CollectionReference?
    private let db = Firestore.firestore()
    var statusArray: [Status]?
    func getStatus(completionHandler: @escaping (_ result: Bool,_ error: Bool?) -> Void){
        reference = db.collection("stories")
        reference?.getDocuments { (querySnapshot, err) in
            if let err = err {
                
            }else{
                for document in querySnapshot!.documents {
                
                    if let userID = document["userID"] as? String,
                       let statusImage = document["statusImage"] as? String,
                        let timeStamp = document["TimeStamp"] as? Double {
                        self.statusArray?.append(Status(image: statusImage,
                                                        timeStamp: timeStamp,
                                                        user: userID))
                    }
                }
            }
        }
    }
}
