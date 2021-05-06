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

class StatusToDelete {
    var user: String
    
    init(user: String){
        self.user = user
    }
}

class StatusRequest {
    private var reference: CollectionReference?
    private let db = Firestore.firestore()
    var statusArray = [Status]()
    var allStatus = [Status]()
    var statusDeleted = [StatusToDelete]()
    let currentDate = Date().timeIntervalSince1970
    var userStatusDelete = [String]()
    func getStatus(ChildKey: String, completionHandler: @escaping (_ result: Bool,_ error: Bool?) -> Void){
       
        let status = db.collection("stories").order(by: "TimeStamp", descending: false)
        status.getDocuments { (querySnapshot, err) in
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
                                
                                self.statusDeleted.append(StatusToDelete(user: userID))
                                let statusToDelete = self.db.collection("stories").document(document.documentID)
                                statusToDelete.delete()
                            }else{
                                if self.allStatus.contains(where: { ($0.image == statusImage)}) {} else {
                                    self.allStatus.append(Status(image: statusImage,
                                    timeStamp: timeStamp,
                                    user: userID))
                                }
                                
                            }
                        }
                    }
                }
                self.removeStatus()
                completionHandler(true,nil)
            }
        }
    }
    
    func removeStatus(){

        for itens in statusDeleted {
            if allStatus.contains(where: { $0.user == itens.user}) {} else {
                let statusToDelete = self.db.collection("users").document(itens.user).updateData(["hasStatusActive": false])
            }
        }
    }
    
}
