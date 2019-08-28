//
//  NationTableViewCell.swift
//  HereThere2
//
//  Created by 우소연 on 29/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class NationTableViewCell: UITableViewCell {
    let chk : UIImage = UIImage(named:"ic_click")!
    let unchk : UIImage = UIImage(named:"ic_unclick")!
    
  //  weak var delegate: CustomCellDelegate?
    @IBOutlet weak var chckbtn: UIButton!
    @IBOutlet weak var nationLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nationLabel.text = nil
        if(chckbtn.currentImage == chk){
            chckbtn.setImage(chk, for: UIControl.State.normal)
        }else{
            chckbtn.setImage(unchk, for: UIControl.State.normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
