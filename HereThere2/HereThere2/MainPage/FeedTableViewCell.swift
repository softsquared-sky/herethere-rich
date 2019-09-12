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
    @IBOutlet weak var heartLbl: UILabel!
    @IBOutlet weak var replyLbl: UILabel!
    var finishReload: Bool = false
   
    
    //Cell.feedView.frame = CGRect(x: mar, y: 20, width: 60, height: 60)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        //feedLbl.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
