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
    
    func repos(pageSize: Int, pageIndex: Int, result: @escaping GetResult)
}
