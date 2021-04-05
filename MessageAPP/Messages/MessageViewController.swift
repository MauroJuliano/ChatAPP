//
//  MessagesViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore
import FirebaseAuth
import Kingfisher
struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}


class MessageViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    
    var timer: Timer?
    var userSelected: User?
    var userRequest = UserRequest()
    var messages: [Message] = []
    var chatIdSelected: Friends?
    var currentUserMessageStyle: MessageStyle?
    var otherUserMessageStyle: MessageStyle?
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    var ref: DocumentReference? = nil
    
    let uid = Auth.auth().currentUser?.uid
    var image = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userRequest.getUsers(completionHandler: { success, _ in
            if success {
                
                for itens in self.userRequest.users {
                    if itens.userID == self.uid {
                        self.image = itens.image
                   
                    }
                }
            }
        })
        navigationController?.navigationBar.tintColor = .black
        updateMessageStyle()
        self.navigationController?.navigationBar.isHidden = false
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let placeholder = UIColor(hexString: "A4A4A4")
        messageInputBar.sendButton.setTitleColor(placeholder, for: .disabled)
        messageInputBar.sendButton.setTitleColor(.black, for: .normal)
        
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector( loadAllMessages), userInfo: nil, repeats: true)
  
        loadAllMessages()
        configureMessageInputBar()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @objc func loadAllMessages(){
        if let chatId = chatIdSelected?.chatID {
            userRequest.getActiveChats(chatId: chatId, completionHandler: { success, _ in
               if success {
                for itens in self.userRequest.messages {
                }
                 self.messagesCollectionView.reloadData()
                 self.messagesCollectionView.scrollToLastItem()
                 }
             })
         }
    }
    private func configureMessageInputBar(){
         guard let otherColor = GradientColors(rawValue: "aubergine") else {return}
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
         gradientLayer.locations = [0.0 , 1.0]
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
         gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
         gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: messageInputBar.sendButton.frame.size.width, height: messageInputBar.sendButton.frame.size.height)
        
            messageInputBar.sendButton.layer.insertSublayer(gradientLayer, below: messageInputBar.sendButton.layer.sublayers?.last)
        
        messageInputBar.delegate = self
        messageInputBar.sendButton.sizeToFit()
        messageInputBar.inputTextView.tintColor = otherColor.gradient.first

    }

    func currentSender() -> SenderType {
        return userRequest.currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return userRequest.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return userRequest.messages.count
    }
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    private func updateMessageStyle(){
        
        guard let currentColor = GradientColors(rawValue: "pinky") else {return}
        guard let otherColor = GradientColors(rawValue: "aubergine") else {return}
  
        messagesCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper")!)
        currentUserMessageStyle = MessageStyle.custom({ (containerView) in
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
            gradientLayer.locations = [0.0 , 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            containerView.layer.insertSublayer(gradientLayer, below: containerView.layer.sublayers?.last)
            containerView.roundCorners([.bottomLeft, .topLeft, .bottomRight], radius: 15)
        })
        
        
        otherUserMessageStyle = MessageStyle.custom({ (containerView) in
                   let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [currentColor.gradient.first.cgColor, currentColor.gradient.second.cgColor]
                   gradientLayer.locations = [0.0 , 1.0]
                   gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
                   gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                   gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                   containerView.layer.insertSublayer(gradientLayer, below: containerView.layer.sublayers?.last)
                   containerView.roundCorners([.bottomRight, .topLeft, .topRight], radius: 15)
       })
    }

}

extension MessageViewController: InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        guard let chatInfo = chatIdSelected else { return }
        let messageSend = db.collection("channels").document(chatInfo.chatID).collection("thread")
         messageSend.addDocument(data: ["content" : "\(text)",
                                        "time": -5,
                                        "sender": uid,
                                        "receiver": chatInfo.userID,
                                        "timeStamp": Date().timeIntervalSince1970])
       
        let currenttUser = db.collection("users").document(self.uid!).collection("contatos").document(chatInfo.userID)
        currenttUser.updateData(["lastMessage": "\(text)", "timeStamp": Date().timeIntervalSince1970])
       
        let othertUser = db.collection("users").document(chatInfo.userID).collection("contatos").document(self.uid!)
        othertUser.updateData(["lastMessage": "\(text)", "timeStamp": Date().timeIntervalSince1970])
        
         inputBar.inputTextView.text = ""
         loadAllMessages()
    }
}

extension MessageViewController: MessageCellDelegate{

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        if message.sender.senderId ==  userRequest.uid {
            return self.currentUserMessageStyle ?? .bubble
        }else {
            return self.otherUserMessageStyle ?? .bubble
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        guard message.sender.senderId != uid else {
                 
        let url = URL(string: image ?? "")
        avatarView.kf.setImage(with: url)
         return
        }
        avatarView.isHidden = false
        let url = URL(string: chatIdSelected?.image ?? "")
        avatarView.kf.setImage(with: url)
    }
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

