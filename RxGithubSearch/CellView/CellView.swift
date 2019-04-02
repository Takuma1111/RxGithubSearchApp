//
//  CellView.swift
//  RxGithubSearch
//
//  Created by 村上拓麻 on 2019/03/29.
//  Copyright © 2019 村上拓麻. All rights reserved.
//

import UIKit
import RxCocoa

class CellView: UITableViewCell {

 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
