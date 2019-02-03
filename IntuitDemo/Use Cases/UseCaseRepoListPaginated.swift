//
//  UseCaseRepoPaginator.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

class UseCaseRepoListPaginated {
    
    typealias GetResult = ((_ repos: [Repo]) -> ())?
    typealias ReposChanged = (_ repos: [Repo]) -> ()
    
    let pageSize: Int
    var pageIndex: Int = 0
    var canLoadMore = true
    let repoRepository: RepoRepositoryProtocol
    var repos: [Repo] = [] {
        didSet {
            reposChanged?(repos)
        }
    }
    
    var reposChanged: ReposChanged?
    
    init(pageSize: Int, repoRepository: RepoRepositoryProtocol) {
        self.pageSize = pageSize
        self.repoRepository = repoRepository
        self.repos = repoRepository.repos
    }
    
    func firstPage(finished: GetResult = nil) {
        
        self.canLoadMore = true
        
        self.repoRepository.firstReposPage(pageSize: pageSize) { [weak self, pageSize] (repos) in
            
            guard pageSize > 0 && pageSize <= 100 else {
                Logger.error("Expexting page size between 1 and 100")
                finished?([])
                return
            }
            
            if repos.count == 0 || repos.count < pageSize {
                self?.canLoadMore = false
            }
            
            self?.repos = repos
            self?.pageIndex = 1
            finished?(repos)
        }
    }
    
    func nextPage(finished: GetResult = nil) {
        
        if !canLoadMore {
            return
        }
        
        self.repoRepository.nextReposPage(pageSize: pageSize) { [weak self, pageSize] (repos) in
            
            guard pageSize > 0 && pageSize <= 100 else {
                Logger.error("Expexting page size between 1 and 100")
                finished?([])
                return
            }
            
            if repos.count == 0 || repos.count < pageSize {
                self?.canLoadMore = false
            }
            
            self?.repos += repos
            self?.pageIndex += 1
            finished?(repos)
        }
    }
}
