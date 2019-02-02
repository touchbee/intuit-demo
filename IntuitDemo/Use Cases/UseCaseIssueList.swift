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
        
        self.issueRepository.issues(repo: repo) { [finished] (issues) in
            self.issues = issues
            finished?(issues)
        }
    }
    
    /*
    func firstPage(finished: GetResult = nil) {
        
        self.repoRepository.repos(pageSize: pageSize, pageIndex: 1) { [weak self, pageSize] (repos) in
            
            if repos.count == 0 || repos.count < pageSize {
                self?.canLoadMore = false
            }
            
            self?.repos = repos
            self?.pageIndex = 2
            finished?(repos)
        }
    }
    
    func nextPage(finished: GetResult = nil) {
        
        if !canLoadMore {
            return
        }
        
        self.repoRepository.repos(pageSize: pageSize, pageIndex: pageIndex) { [weak self, pageSize] (repos) in
            
            if repos.count == 0 || repos.count < pageSize {
                self?.canLoadMore = false
            }
            
            self?.repos += repos
            self?.pageIndex += 1
            finished?(repos)
        }
    }
 */
}
