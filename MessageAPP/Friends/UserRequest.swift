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
    let uid = Auth.auth().currentUser?.uid
    var currentUser = Sender(senderId: "self", displayName: "Rhyssand")
    var otherUser = Sender(senderId: "other", displayName: "Freyre")
    
    var messages: [Message] = []
    var users: [Users] = []
    var friends: [Friends] = []
    var emailRequest: String?
    var chatActive: [Friends] = []
    var statusActive: [Users] = []
    var friendsStatus: [Friends] = []
    func getUsers(completionHandler: @escaping (_ result: Bool,_ result: Bool?) -> Void ){
        self.statusActive.removeAll()
        reference = db.collection("users")
        reference?.getDocuments { (querySnapshot, err) in
            if let err = err {
       
            }else {
                for document in querySnapshot!.documents {
                    
                if let name = document["name"] as? String,
                   let email = document["email"] as? String,
                   let userID = document["userID"] as? String,
                   let image = document["imageProfile"] as? String,
                   let bio = document["Bio"] as? String{
                   var hasStatusActive = document["hasStatusActive"] as? Bool
                    
                    if hasStatusActive == true {
                      self.statusActive.append(Users(userID: userID,
                                              email: email,
                                              name: name,
                                              image: image,
                                              bio: bio, hasStatusActive: hasStatusActive ?? false))
                   
                    }
                    self.users.append(Users(userID: userID,
                                                       email: email,
                                                       name: name, image: image,
                                                       bio: bio, hasStatusActive: hasStatusActive ?? false))
             }
         }
                completionHandler(true,nil)
      }
   }
  }
    
    func getContato(completionHandler: @escaping  (_ result: Bool,_ result: Bool?) -> Void) {
        self.friendsStatus.removeAll()
        let contact = db.collection("users").document(self.uid!).collection("contatos").order(by: "timeStamp", descending: true)
        contact.getDocuments { (querySnapshot, err) in
            if let err = err {
            }else {
                for document in querySnapshot!.documents {
                    if let userID = document["userID"] as? String {
                        var chatID = document["chatID"] as? String
                        var lastMessage = document["lastMessage"] as? String
                        var timeStamp = document["timeStamp"] as? Double
                        
                        for itens in self.users {
                         
                            if chatID != nil {
                                if self.chatActive.contains(where: {$0.chatID == chatID}){
                                } else {
                                
                                    if userID == itens.userID {
                                        self.chatActive.append(Friends(userID: userID,
                                        email: itens.email,
                                        name: itens.name,
                                        image: itens.image,
                                        chatID: chatID ?? "", bio: itens.bio,timeStamp:"\(timeStamp!)" ?? "", lastMessage: lastMessage ?? ""))

                                        chatID = ""
                                    }
                                }
                            }
                            
                            if userID == itens.userID {
                                if self.friends.contains(where: { $0.userID == userID}){ } else {
                                    self.friends.append(Friends(userID: userID,
                                    email: itens.email,
                                    name: itens.name,
                                    image: itens.image,
                                    chatID: chatID ?? "", bio: itens.bio,timeStamp:"\(timeStamp!)" ?? "", lastMessage: lastMessage ?? ""
                                    ))
                               }
                            }
                            
                        }
                        
                        for itens in self.statusActive {
                            if userID == itens.userID {
                                if self.friendsStatus.contains(where: { $0.userID == userID}){ print(itens.name
                                    )} else {
                                          self.friendsStatus.append(Friends(userID: userID,
                                                                   email: itens.email,
                                                                   name: itens.name,
                                                                   image: itens.image,
                                                                   chatID: chatID ?? "", bio: itens.bio,timeStamp:"\(timeStamp!)" ?? "", lastMessage: lastMessage ?? ""
                                                                   ))
                                                              }
                            }
                        }
                         completionHandler(true, nil)
                       
                    }
                }
            }
        }
        
    }
    
    func getActiveChats(chatId: String ,completionHandler: @escaping  (_ result: Bool,_ result: Bool?) -> Void){

        let chats = db.collection("channels").document(chatId).collection("thread").order(by: "timeStamp")

        chats.getDocuments { (querySnapshot, err) in
            
            if let err = err {
               
            } else {
                for document in querySnapshot!.documents {
                    
                    if let sender = document["sender"] as? String,
                       let receiver = document["receiver"] as? String,
                       let time = document["time"] as? Int,
                       let content = document["content"] as? String {
                       let messageID = document.documentID
                        
                        if self.messages.contains(where: { $0.messageId == messageID }) {} else {
                        if sender == self.uid {
                            self.currentUser = Sender(senderId: sender, displayName: "")
                            
                            self.messages.append(Message(sender: self.currentUser, messageId: messageID, sentDate: Date().addingTimeInterval(TimeInterval(time)), kind: .text(content)))
                        }else {
                            self.otherUser = Sender(senderId: sender, displayName: "")
                            self.messages.append(Message(sender: self.otherUser, messageId: messageID, sentDate: Date().addingTimeInterval(TimeInterval(time)), kind: .text(content)))
                        }
                    }
                       
                        completionHandler(true,nil)
                      
                    }
                }
            }
        }
 }
}
