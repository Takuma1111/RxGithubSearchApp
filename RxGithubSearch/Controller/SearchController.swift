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
import SafariServices
import FontAwesome_swift

class SearchController: UIViewController{

    @IBOutlet weak var navigationBar: UINavigationItem!     //navigatinBar
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    private let viewModel = GithubSearchAPIViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableにcellを登録
        table.register(UINib(nibName: "CellView", bundle: nil), forCellReuseIdentifier: "CellView")
        
        
        //検索ワードをviewModelに渡す
        self.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.searchWord)
            .disposed(by: self.disposeBag)
        
        // 検索結果とテーブルのセルをbind
        self.viewModel.items.asObservable()
            .bind(to: self.table.rx.items) { tableView, row, element in


                let cell = self.table.dequeueReusableCell(withIdentifier: "CellView")! as! CellView
                
                cell.titleLabel?.text = element.title
                cell.urlLabel?.text = element.url

                return cell
            }
            .disposed(by: self.disposeBag)
        
        //Webページを表示
        self.table.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.table.cellForRow(at: indexPath)
                if let url = cell?.detailTextLabel?.text, let urlSourse = URL(string: url) {
                    let safariViewController = SFSafariViewController(url: urlSourse)
                    self?.present(safariViewController, animated: true)
                }
            }).disposed(by: disposeBag)
        
        //ナビゲーションバーのテキストを変更FontAwesomeを使用して
        navigationBar.title =  "Git \(String.fontAwesomeIcon(name: .github)) hub"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 30, style: .brands)]
        //ナビゲーションバーの色を変更
        self.navigationController?.navigationBar.barTintColor = .gray
        self.navigationController?.navigationBar.tintColor = .white

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
