//
//  DatastoreFactory.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

class RepositoryFactory {
    
    enum Purpose {
        case Production
        case Testing
    }
    
    let purpose: Purpose
    
    init(purpose: Purpose) {
        self.purpose = purpose
    }
    
    func repoDatstore() -> RepoRepositoryProtocol {
       
        switch purpose {
        case .Production:
            return RepoRepository(url: URL.GitHubAccountIntuit)
        case .Testing:
            return RepoRepository(url: URL.GitHubAccountIntuit)
        }
    }
    
    func issuesDatastore() -> IssueRepositoryProtocol {
        
        switch purpose {
        case .Production:
            return IssueRepository()
        case .Testing:
            return IssueRepository()
        }
    }
}
