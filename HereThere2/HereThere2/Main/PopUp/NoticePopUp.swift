//
//  NoticePopUp.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//


import UIKit

class NoticePopUp: BaseViewController {
    var noticePopUpDelegate: NoticePopUpDelegate!
    
  
    @IBAction func pressedDismiss(_ sender: UIButton) {
        self.noticePopUpDelegate.pressedDismissButton()
        self.dismiss(animated: false, completion: nil)
    }
}
