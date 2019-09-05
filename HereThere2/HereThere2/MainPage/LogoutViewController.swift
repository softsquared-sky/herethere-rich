//
//  LogoutViewController.swift
//  HereThere2
//
//  Created by 우소연 on 31/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {

    
    @IBAction func gomainbtn(_ sender: Any) {
        self.navigationController!.pushViewController(LoginViewController(), animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
