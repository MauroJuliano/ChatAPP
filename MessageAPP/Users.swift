//
//  Users.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation

struct Users: Decodable, Equatable {
    let userID: String
    let email: String
    let name: String
    let image: String
    let bio: String
    let hasStatusActive: Bool
    
    init(userID: String, email: String, name: String, image: String, bio: String, hasStatusActive: Bool){
        self.userID = userID
        self.email = email
        self.name = name
        self.image = image
        self.bio = bio
        self.hasStatusActive = hasStatusActive
    }
//    enum CodingKeys: String, CodingKey {
//        case userID = "userID"
//        case name = "name"
//        case email = "email"
//        case image = "image"
//        case bio = "Bio"
//    }
}

struct Contatos: Decodable, Equatable {
    
    var chatID: String
    var userID: String
    
    enum CodingKeys: String, CodingKey {
        case chatID = "chatID"
        case userID = "userID"
    }
    
}

struct Friends: Decodable, Equatable {
    
    var userID: String
    var email: String
    var name: String
    var image: String
    var chatID: String
    var bio: String
    var timeStamp: String
    var lastMessage: String
    enum CodingKeys: String, CodingKey {
        
        case userID = "userID"
        case email = "email"
        case name = "name"
        case image = "image"
        case chatID = "chatID"
        case bio = "bio"
        case timeStamp = "timeStamp"
        case lastMessage = "lastMessage"
        
    }
}
