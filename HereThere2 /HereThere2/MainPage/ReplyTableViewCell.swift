//
//  ReplyTableViewCell.swift
//  HereThere2
//
//  Created by 우소연 on 08/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
