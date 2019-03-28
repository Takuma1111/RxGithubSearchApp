//
//  GithubSearchAPIViewModel.swift
//  RxGithubSearch
//
//  Created by 村上拓麻 on 2019/03/28.
//  Copyright © 2019 村上拓麻. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GithubSearchAPIViewModel{
    

    var searchWord = Variable<String>("")
    var items = Variable<[Response]>([])

    private let model = GithubSearchAPIModel()
    private var disposeBag = DisposeBag()
    
    init(){
        searchWord.asObservable()
            .filter{ $0.count >= 2 }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] str in
                return self.model.searchGithub(["q":str])
        }
            .bind(to: self.items)
            .disposed(by: disposeBag)
    }
}
