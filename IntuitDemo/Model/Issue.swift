//
//  Issue.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

struct Issue : Codable {
    
    let id: Int
    let title: String
    let state: String
    let created: Date
    
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case state
        case created = "created_at"
        case user = "user"
    }
}
