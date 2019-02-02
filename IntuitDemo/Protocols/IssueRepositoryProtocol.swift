//
//  IssueRepositoryProtocol.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

protocol IssueRepositoryProtocol {
    
    typealias GetResult = (_ issues: [Issue]) -> ()
    
    func issues(repo: Repo, result: @escaping GetResult)
}
