//
//  ResponseCell.swift
//  RxGithubSearch
//
//  Created by 村上拓麻 on 2019/03/26.
//  Copyright © 2019 村上拓麻. All rights reserved.
//

import UIKit

class ResponseCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var launguage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
