//
//  FeedTableViewCell.swift
//  HereThere2
//
//  Created by 우소연 on 31/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var reviseBtn: UIButton!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var feedLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var timeagoLbl: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        feedLbl.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
