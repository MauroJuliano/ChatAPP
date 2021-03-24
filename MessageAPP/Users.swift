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
    
    enum CodingKeys: String, CodingKey {
        case userID = "userID"
        case name = "name"
        case email = "email"
    }
}
