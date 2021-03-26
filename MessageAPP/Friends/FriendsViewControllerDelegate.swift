//
//  FriendsViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class FriendsViewControllerDelegate: NSObject, UITableViewDelegate, UITableViewDataSource{
    private var view: FriendsViewController?
    private var uid = Auth.auth().currentUser?.uid
    private let db = Firestore.firestore()
     private let databaseReference: DatabaseReference = Database.database().reference()
    
    init(view: FriendsViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageId = self.databaseReference.childByAutoId().key!
        guard let index = view?.friendsArray[indexPath.row] else {return}
        
        let channels = db.collection("channels").document("\(messageId)").collection("whoIS")
        
        channels.addDocument(data: [
            "chatID": "\(messageId)",
            "user1": "\(self.uid!)",
            "user2": "\(index.userID)"])
        
        let othertUser = db.collection("users").document(index.userID).collection("contatos").document(self.uid!)
        othertUser.updateData(["chatID": "\(messageId)"])
        
        let currenttUser = db.collection("users").document(self.uid!).collection("contatos").document(index.userID)
        currenttUser.updateData(["chatID": "\(messageId)"])
        
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return view?.friendsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        guard let indexpath = view?.friendsArray[indexPath.row] else {return cell }
        cell.setup(friend: indexpath)
        return cell
    }
    
    
}
