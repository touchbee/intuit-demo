//
//  IssueRepository.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

class IssueRepository : IssueRepositoryProtocol {
    
    typealias GetResult = (_ issues: [Issue]) -> ()
    
    var remoteDataSource: IssueRemoteDatasource
    var issues: [Int:[Issue]] = [:]
    
    init() {
        self.remoteDataSource = IssueRemoteDatasource()
    }
    
    func allIssues(repo: Repo, result: @escaping GetResult) {
        
        if let issues = issues[repo.id] {
            result(issues)
        }
        else {
            
            remoteDataSource.issues(for: repo) { [weak self] (issues) in
                 self?.issues[repo.id] = issues
                    result(issues)
            }
        }
    }
}
