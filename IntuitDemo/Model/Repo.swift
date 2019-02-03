//
//  Repository.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

struct Repo : Codable {
    
    let id: Int
    let name: String
    let fullName: String
    let watchersCount: Int
    let issuesCount: Int
    let forkCount: Int
    let description: String
    let language: String?
    let created: Date
    let issuesUrlPath: String
    
    var issuesUrl: URL? {
        guard let path = issuesUrlPath.components(separatedBy: "{").first else {
            return nil
        }
        return URL(string: path)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case watchersCount = "watchers_count"
        case issuesCount = "open_issues_count"
        case forkCount = "forks_count"
        case description
        case language
        case created = "created_at"
        case issuesUrlPath = "issues_url"
    }
}
