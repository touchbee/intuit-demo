//
//  RepoRepository.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

class RepoRepository : RepoRepositoryProtocol {
    
    typealias GetResult = (_ repos: [Repo]) -> ()
    
    var remoteDataSource: RepoRemoteDatasource
    var repos: [Repo] = []
    var loadedPageIndex: Int = 0
    
    init(url: URL) {
        self.remoteDataSource = RepoRemoteDatasource(url: url)
    }
    
    func firstReposPage(pageSize: Int, result: @escaping GetResult) {
        
        repos.removeAll()
        loadedPageIndex = 0
        
        remoteDataSource.repos(pageSize: pageSize, pageIndex: 0) { [weak self] (repos) in
            
            self?.repos = repos
            self?.loadedPageIndex += 1
            
            result(repos)
        }
    }
    
    func nextReposPage(pageSize: Int, result: @escaping GetResult) {
        
        remoteDataSource.repos(pageSize: pageSize, pageIndex: loadedPageIndex) { [weak self] (repos) in
            
            self?.repos += repos
            self?.loadedPageIndex += 1
            
            result(repos)
        }
    }
    
   

    /*
    
    func fetchRepos(pageSize: Int, pageIndex: Int, result: @escaping GetResult) {
        
        if pageIndex == 0 {
            repos.removeAll()
            loadedPageIndex = 0
        }
        
        remoteDataSource.repos(pageSize: pageSize, pageIndex: pageIndex) { [weak self] (repos) in
            
            if pageIndex > 0 {
                self?.repos += repos
            }
            else {
                self?.repos = repos
            }
            
            self?.loadedPageIndex += 1
            
            result(repos)
        }
    }
 */
}
