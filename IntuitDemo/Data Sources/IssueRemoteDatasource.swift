//
//  IssueRemoteDatasource.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class IssueRemoteDatasource {
    
    typealias GetResult = (_ issues: [Issue]) -> ()
    
    func issues(for repo: Repo, result: @escaping GetResult) {
        
        guard let issuesUrl = repo.issuesUrl else {
            result([])
            return
        }
        
        print(issuesUrl)
        
        Alamofire.request(issuesUrl).responseJSON { response in
            
            guard response.result.isSuccess, let json = response.data else {
                log.error("Missing issues URL")
                result([])
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let issues = try decoder.decode([Issue].self, from: json)
                result(issues)
            } catch {
                result([])
            }
        }
    }
}
