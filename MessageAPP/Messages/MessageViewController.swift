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
    
    var userSelected: User?
    let currentUser = Sender(senderId: "self", displayName: "Rhyssand")
    var otherUser = Sender(senderId: "other", displayName: "Freyre")
    var messages: [Message] = []
    
    var currentUserMessageStyle: MessageStyle?
    var otherUserMessageStyle: MessageStyle?
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    var ref: DocumentReference? = nil
    
    let uid = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = userSelected else {return}
        otherUser = Sender(senderId: "other", displayName: user.name ?? "")
        navigationController?.navigationBar.tintColor = .black
        updateMessageStyle()
        self.navigationController?.navigationBar.isHidden = false
        messages.append(Message(sender: currentUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("hello world")))
       
        messages.append(Message(sender: otherUser,
                                       messageId: "2",
                                       sentDate: Date().addingTimeInterval(-70000),
                                       kind: .text("how is it going")))
        
        messages.append(Message(sender: currentUser,
                                       messageId: "3",
                                       sentDate: Date().addingTimeInterval(-60000),
                                       kind: .text("here is a long reply. here is a long reply. here is a long reply. here is a long reply. here is a long reply. here is a long reply. ")))
        
        messages.append(Message(sender: currentUser,
                                       messageId: "4",
                                       sentDate: Date().addingTimeInterval(-50000),
                                       kind: .text("look it works")))
        
        messages.append(Message(sender: otherUser,
                                       messageId: "5",
                                       sentDate: Date().addingTimeInterval(-40000),
                                       kind: .text("I love making apps. I love making apps. I love making apps. I love making apps. I love making apps. I love making apps. ")))
        
        messages.append(Message(sender: currentUser,
                                       messageId: "6",
                                       sentDate: Date().addingTimeInterval(-30000),
                                       kind: .text("the last message")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let placeholder = UIColor(hexString: "A4A4A4")
        messageInputBar.sendButton.setTitleColor(placeholder, for: .disabled)
        messageInputBar.sendButton.setTitleColor(.black, for: .normal)
        
        //messageInputBar.inputTextView.placeholderTextColor = UIColor(hexString: "A4A4A4")
        configureMessageInputBar()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    private func updateMessageStyle(){
        
        guard let currentColor = GradientColors(rawValue: "pinky") else {return}
        guard let otherColor = GradientColors(rawValue: "aubergine") else {return}
      
        currentUserMessageStyle = MessageStyle.custom({ (containerView) in
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
            gradientLayer.locations = [0.0 , 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            containerView.layer.insertSublayer(gradientLayer, below: containerView.layer.sublayers?.last)
            containerView.roundCorners([.bottomLeft, .topLeft, .topRight], radius: 15)
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
        
        let testMessage = Message(sender: currentUser,
                                  messageId: "7",
                                  sentDate: NSDate(timeIntervalSinceNow: -2) as Date,
                                  kind: .text(text))
        
        insertNewMessage(testMessage)
        save(testMessage)
        inputBar.inputTextView.text = ""
    }
    
    private func insertNewMessage(_ message: Message){
        guard !messages.contains(where: {$0.messageId == message.messageId}) else {return}
        messages.append(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    private func save(_ message: Message){
        ref = db.collection("channels").addDocument(data: [
                                       "created": message.sentDate,
                                       "senderID": uid,
                                       "senderName": "teste"])
        
        messagesCollectionView.scrollToBottom()
    }
}

extension MessageViewController: MessageCellDelegate{

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        if message.sender.senderId == "self" {
            return self.currentUserMessageStyle ?? .bubble
        }else {
            return self.otherUserMessageStyle ?? .bubble
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        guard message.sender.senderId == "other" else {
            avatarView.isHidden = true
            return
        }
        avatarView.image = UIImage(named: userSelected?.image ?? "")
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
