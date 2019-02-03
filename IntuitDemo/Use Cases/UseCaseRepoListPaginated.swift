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
    
    var sortedByName: (_ : Repo, _ : Repo) -> Bool = { $0.name.lowercased() < $1.name.lowercased() }
    var sortFunc: (_ : Repo, _ : Repo) -> Bool
    
    
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
        self.sortFunc = sortedByName
        self.repoRepository = repoRepository
        self.repos = repoRepository.repos.sorted(by: sortFunc)
    }
    
    func firstPage(finished: GetResult = nil) {
        
        self.canLoadMore = true
        
        self.repoRepository.firstReposPage(pageSize: pageSize) { [weak self, pageSize] (repos) in
            
            guard let sortFunc = self?.sortFunc, pageSize > 0 && pageSize <= 100 else {
                Logger.error("Expexting page size between 1 and 100")
                finished?([])
                return
            }
            
            if repos.count == 0 || repos.count < pageSize {
                self?.canLoadMore = false
            }
            
            self?.repos = repos.sorted(by:sortFunc)
            self?.pageIndex = 1
            finished?(repos)
        }
    }
    
    func nextPage(finished: GetResult = nil) {
        
        if !canLoadMore {
            return
        }
        
        self.repoRepository.nextReposPage(pageSize: pageSize) { [weak self, pageSize] (repos) in
            
            guard let sortFunc = self?.sortFunc, let allRepos = self?.repos, pageSize > 0 && pageSize <= 100 else {
                Logger.error("Expexting page size between 1 and 100")
                finished?([])
                return
            }
            
            if repos.count == 0 || repos.count < pageSize {
                self?.canLoadMore = false
            }
           
            self?.repos = (allRepos + repos).sorted(by:sortFunc)
            self?.pageIndex += 1
            finished?(repos)
        }
    }
}
