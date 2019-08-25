//
//  createUserViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import Firebase

class createUserViewController: UIViewController {

    @IBOutlet weak var cemailTextField: UITextField!
    @IBOutlet weak var cpwTextField: UITextField!
    
    @IBAction func createUserbtn(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: cemailTextField.text!, password: cpwTextField.text!) { (user, error) in
            if user != nil {
                print("register sucess" )
            }else{
                print("register fail")
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
