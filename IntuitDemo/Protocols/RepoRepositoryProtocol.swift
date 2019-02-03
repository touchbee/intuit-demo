//
//  RepoRepositoryProtocol.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

protocol RepoRepositoryProtocol {
    
    typealias GetResult = (_ repos: [Repo]) -> ()
    
    var repos: [Repo] {get}
    
    func firstReposPage(pageSize: Int, result: @escaping GetResult)
    func nextReposPage(pageSize: Int, result: @escaping GetResult)
}
