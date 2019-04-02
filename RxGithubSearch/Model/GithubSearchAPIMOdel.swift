//
//  GithubSearchAPIModel.swift
//  RxGithubSearch
//
//  Created by 村上拓麻 on 2019/03/28.
//  Copyright © 2019 村上拓麻. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GithubSearchAPIModel {
    let client = GithubAPIClient()
   
    func searchGithub(_ parameters:[String:String]) -> Observable<[Response]>{
        return Observable<[Response]>.create{ (observer) -> Disposable in
            let request = self.client.getRequest(parameters).responseJSON{ response in
                if let error = response.error {
                    observer.onError(error)
                }
                let results = self.parseJson(response.result.value as? [String:Any] ?? [:])
                observer.onNext(results)
                observer.onCompleted()
            }
            return Disposables.create{ request.cancel() }
        }
    }
    
     func parseJson(_ json:Any) -> [Response] {
        guard let items = json as? [String: Any] else {
           print("jsonがなかった")
            return []
        }
        var results = [Response]()
        if let responseItems = items["items"] as? [[String:Any]] {
            print("responseItems",responseItems)
            responseItems.forEach{
                guard let title = $0["full_name"] as? String,
                    let url = $0["html_url"] as? String else { return }
                results.append(Response(title: title, url:url))
            }
        }
        return results
    }
}
