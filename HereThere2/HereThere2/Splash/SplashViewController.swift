//
//  SplashViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func pressedPresentMainViewController(_ sender: UIButton) {
        let customAction = UIAlertAction(title: "확인", style: .destructive) { _ in
            guard let navigationViewController = self.navigationController else {
                self.presentAlert(title: "오류", message: "화면 이동에 실패하였습니다.")
                return
            }
            
            navigationViewController.pushViewController(MainViewController(), animated: true)
        }
        self.presentAlertWithAction(title: "화면전환", message: "메인으로 이동하시겠습니까?", customAction)
    }
    @IBAction func pressedLoginViewController(_ sender: UIButton) {
        self.navigationController!.pushViewController(LoginViewController(), animated: true)
        
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
