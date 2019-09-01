//
//  LoginViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: BaseViewController {
    
   
    let loginOk : UIImage = UIImage(named:"ic_login_accessed")!
    let loginnotOk : UIImage = UIImage(named:"ic_login_notaccessed")!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var newCustomer: UIButton!
    
    @IBOutlet weak var logoutbtn: UIButton!
    @IBOutlet weak var loginbtnPushed: UIButton!{
        didSet{
            loginbtnPushed.isEnabled = false
            //loginbtnPushed.setTitleColor(UIColor.black, for: .normal)
            loginbtnPushed.setImage(loginnotOk, for: UIControl.State.normal)
        }
    }
    @IBAction func loginbtnPushed(_ sender: Any) {
        let params = ["email" : self.emailTextField.text!, "password": self.pwTextField.text!]
       MainDataManager().getLogin(self, params)
        
        
        /*Auth.auth().signIn(withEmail: emailTextField.text!, password: pwTextField.text!) { (user, error) in
            if user != nil{
                print("login success")
            }
            else{
                print("login fail")
                self.presentAlert(title: "", message: "입력하신 이메일 또는 비밀번호가 잘못되었거나, 가입되어있는 정보가 없습니다.")
            }
            
        }*/
    }
    @IBAction func newCustomer(_ sender: Any) {
       //self.navigationController!.pushViewController(HamMenuViewController(), animated: true) //self.navigationController!.pushViewController(createUserViewController(), animated: true)
        ///////self.navigationController!.pushViewController(NewEmailViewController(), animated: true)
        self.navigationController!.pushViewController(SNationViewController(), animated: true)
        /*let hamStoryboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
        guard let hammenu = hamStoryboard.instantiateViewController(withIdentifier: "hampage") as? HampageViewController else {
            return
        }
        
        hammenu.modalPresentationStyle = .custom
        self.present(hammenu, animated: true, completion: nil)
         
         let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = mainStoryboard.instantiateViewController(withIdentifier: "Mainhome")
         self.navigationController?.pushViewController(viewController, animated: true)
         //self.window?.rootViewController = viewController
         */
        /*
        let hamStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let uvc = hamStoryboard.instantiateViewController(withIdentifier: "homeview") as? HomeViewController else { return }
        // 화면을 전환할 때 애니메이션 정의
        
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        // 화면을 전환한다
        self.navigationController?.pushViewController(uvc, animated: true)
        */
        
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
    
    
    var attrs = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    
    var newuserattributedString = NSMutableAttributedString(string:"")
    var findattributedString = NSMutableAttributedString(string:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let swiftColor = UIColor(red: 0/255.0, green: 159/255.0, blue: 229/255.0, alpha: 1.0)
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        emailTextField.attributedPlaceholder = NSAttributedString(string: "메일주소@email.com",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let newuserbtnTitleStr = NSMutableAttributedString(string:"회원가입", attributes:attrs)
        let findbtnTitleStr = NSMutableAttributedString(string:"이메일/비밀번호 찾기", attributes:attrs)
        newuserattributedString.append(newuserbtnTitleStr)
        findattributedString.append(findbtnTitleStr)
        
        newCustomer.setAttributedTitle(newuserattributedString, for: .normal)
        findBtn.setAttributedTitle(findattributedString, for: .normal)
        logoutbtn.isHidden = true
        loginbtnPushed.isHidden = false
        //loginbtnPushed.isEnabled = true
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

extension LoginViewController : UITextFieldDelegate{
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(self.isValidEmail(emailStr: self.emailTextField.text!) && self.validatePassword(passStr: self.pwTextField.text!)){
            loginbtnPushed.isEnabled = true
            //loginbtnPushed.setTitleColor(UIColor.blue, for: .normal)
            loginbtnPushed.setImage(loginOk, for: UIControl.State.normal)
        }else{
            loginbtnPushed.isEnabled = false
            //loginbtnPushed.setTitleColor(UIColor.black, for: .normal)
            loginbtnPushed.setImage(loginnotOk, for: UIControl.State.normal)
        }
        print(emailTextField.text!,range.location, range.length)
        return true
    }
}
