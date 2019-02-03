//
//  UseCaseIssueList.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

class UseCaseIssueList {
    
    typealias GetResult = ((_ repos: [Issue]) -> ())?
    typealias IssuesChanged = (_ repos: [Issue]) -> ()
    
    let repo: Repo!
    let issueRepository: IssueRepositoryProtocol
    var issues: [Issue] = [] {
        didSet {
            issuesChanged?(issues)
        }
    }
    
    var issuesChanged: IssuesChanged?
    
    init(repo: Repo, issueRepository: IssueRepositoryProtocol) {
        self.repo = repo
        self.issueRepository = issueRepository
    }
    
    func getIssues(finished: GetResult = nil) {
        
        self.issueRepository.allIssues(repo: repo) { [weak self, finished] (issues) in
            self?.issues = issues
            finished?(issues)
        }
    }
}
