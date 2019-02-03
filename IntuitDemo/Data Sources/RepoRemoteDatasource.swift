//
//  RepoRemoteDatasource.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation
import Alamofire

class RepoRemoteDatasource {
    
    typealias GetResult = (_ repos: [Repo]) -> ()
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func repos(pageSize: Int, pageIndex: Int, result: @escaping GetResult) {
        
        guard let paginationUrl = URL(string: url.absoluteString + "?page=\(pageIndex + 1)&per_page=\(pageSize)") else {
            result([])
            return
        }
        
        print(paginationUrl)
        
        Alamofire.request(paginationUrl).responseJSON { response in
            
            guard response.result.isSuccess, let json = response.data else {
                result([])
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let repos = try decoder.decode([Repo].self, from: json)
                result(repos)
            } catch {
                result([])
            }
        }
    }
}
