//
//  GithubAPIClient.swift
//  RxGithubSearch
//
//  Created by 村上拓麻 on 2019/03/28.
//  Copyright © 2019 村上拓麻. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClient {
    var url: String { get }
    func getRequest(_ parameters: [String : String]) -> DataRequest
}

class GithubAPIClient: APIClient {
    var url = "https://api.github.com/search/repositories"
    
    func getRequest(_ parameters: [String : String]) -> DataRequest{
        return Alamofire.request(URL(string:"https://api.github.com/search/repositories")!,
                                 method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
    }
}
