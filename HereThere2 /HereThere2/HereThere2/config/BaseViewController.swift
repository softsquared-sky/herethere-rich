//
//  BaseViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        CustomIndicatorView.shared.show()
    }
    
    // MARK: 인디케이터 숨김
    func dismissIndicator() {
        CustomIndicatorView.shared.dismiss()
    }
}
