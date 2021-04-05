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
    var allStatus = [Status]()
    let currentDate = Date().timeIntervalSince1970
    var userStatusDelete = [String]()
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
                        
                        if ChildKey == "" {
                            let statusDate = timeStamp + 86400
                            if statusDate <= self.currentDate {
                                if self.userStatusDelete.contains(userID) {} else {
                                    self.userStatusDelete.append(userID)
                                }
                                let statusToDelete = self.db.collection("stories").document(document.documentID)
                                statusToDelete.delete()
                            
                            }  
                        }
                        self.allStatus.append(Status(image: statusImage,
                                                      timeStamp: timeStamp,
                                                      user: userID))
                     
                    }
                }
                completionHandler(true,nil)
            }
        }
    }
    
    func removeStatus(){
        for itens in userStatusDelete {
           // if allStatus.contains({ ($0.u)})
        }
    }
    
}
