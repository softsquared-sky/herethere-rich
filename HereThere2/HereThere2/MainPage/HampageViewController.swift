//
//  HampageViewController.swift
//  HereThere2
//
//  Created by 우소연 on 30/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class HampageViewController: UIViewController {
    var hamburgermenuisvisible = false
   
    let imgIcon = UIImage(named: "ic_hammenu")?.withRenderingMode(.alwaysOriginal)
   
    @IBAction func hamtapped(_ sender: Any) {
        hamview.isHidden = true
    }
    @IBAction func dismissbtn(_ sender: Any) {
        hamview.isHidden = true
    }
    @IBOutlet weak var hamview: UIView!{
        didSet{
            hamview.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
        // Do any additional setup after loading the view.
    }
    
    @objc func menuBtnTapped() {
       hamview.isHidden = true
    }
}
