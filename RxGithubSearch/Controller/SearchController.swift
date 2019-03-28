//
//  SearchController.swift
//  RxGithubSearch
//
//  Created by 村上拓麻 on 2019/03/26.
//  Copyright © 2019 村上拓麻. All rights rese/Users/murakami0120/Downloads/Microsoft_Office_16.23.19030902_Installer.pkgrved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchController: UIViewController{

    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    private let viewModel = GithubSearchAPIViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.searchWord)
            .disposed(by: self.disposeBag)
        
        // 検索結果とテーブルのセルをbind
        self.viewModel.items.asObservable()
            .bind(to: self.table.rx.items(cellIdentifier: "Cell")) { index, result, cell in
                cell.textLabel?.text = result.title
                cell.detailTextLabel?.text = result.name
            }
            .disposed(by: self.disposeBag)


    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
