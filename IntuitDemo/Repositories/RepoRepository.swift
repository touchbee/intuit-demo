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
    
    init(url: URL) {
        self.remoteDataSource = RepoRemoteDatasource(url: url)
    }
    
    func repos(pageSize: Int, pageIndex: Int, result: @escaping GetResult) {
        
        remoteDataSource.repos(pageSize: pageSize, pageIndex: pageIndex) { (repos) in
            result(repos)
        }
    }
}
