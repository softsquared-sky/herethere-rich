//
//  LoginViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func validatePassword(passStr:String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{6,10}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: passStr)
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var newCustomer: UIButton!
    
    @IBOutlet weak var logoutbtn: UIButton!
    @IBOutlet weak var loginbtnPushed: UIButton!{
        didSet{
            loginbtnPushed.isEnabled = true
            loginbtnPushed.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    @IBAction func loginbtnPushed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: pwTextField.text!) { (user, error) in
            if user != nil{
                print("login success")
            }
            else{
                print("login fail")
                self.presentAlert(title: "", message: "입력하신 이메일 또는 비밀번호가 잘못되었거나, 가입되어있는 정보가 없습니다.")
            }
            
        }
    }
    @IBAction func newCustomer(_ sender: Any) {
        self.navigationController!.pushViewController(createUserViewController(), animated: true)

    }
    @IBAction func logoutbtnPushed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }/*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text!,range.location, range.length)
        return true
    }
    */
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(isValidEmail(emailStr: emailTextField.text!) && validatePassword(passStr: pwTextField.text!)){
            loginbtnPushed.isEnabled = true
            loginbtnPushed.setTitleColor(UIColor.blue, for: .normal)
        }else{
            loginbtnPushed.isEnabled = false
            loginbtnPushed.setTitleColor(UIColor.black, for: .normal)
        }
        print(emailTextField.text!,range.location, range.length)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutbtn.isHidden = true
        loginbtnPushed.isHidden = false
        emailTextField.delegate = self
        pwTextField.delegate = self
        if let user = Auth.auth().currentUser{
            emailTextField.placeholder = "이미 로그인됨"
            pwTextField.placeholder = "이미 로그인"
            loginbtnPushed.setTitle("이미 로그인 된 상태", for: .normal)
            loginbtnPushed.isHidden = true
            logoutbtn.isHidden = false
        }
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
