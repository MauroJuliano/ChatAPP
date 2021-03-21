//
//  MessageModel.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
struct MessageUser {
    var messages: String = ""
    var timestamp: String = ""
}

struct User {
    var senderId: String?
    var image: String?
    var name: String?
    var lastMessage: String?
    
    init(senderId: String, image: String, name: String, lastMessage: String){
        self.senderId = senderId
        self.image = image
        self.name = name
        self.lastMessage = lastMessage
    }
}
