//
//  FinishViewController.swift
//  HereThere2
//
//  Created by 우소연 on 29/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class FinishViewController: BaseViewController {
let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var BigLbl: UILabel!{
        didSet{
            BigLbl.text = self.appDelegate.nickName! + "님, 환영합니다!"
        }
    }
    @IBAction func btnPressed(_ sender: Any) {
        self.navigationController!.pushViewController(LoginViewController(), animated: true)
    }
    
    lazy var rightButton: UIBarButtonItem = { let button = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    
    @objc private func buttonPressed(_ sender: Any) { if let button = sender as? UIBarButtonItem {
        switch button.tag {
        case 1: // Change the background color to blue.
            self.navigationController!.pushViewController(HamMenuViewController(), animated: true)
        default:
            break
        }
        }
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        // Do any additional setup after loading the view.
    }
}
