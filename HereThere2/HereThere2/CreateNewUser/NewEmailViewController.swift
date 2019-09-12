//
//  NewEmailViewController.swift
//  HereThere2
//
//  Created by 우소연 on 27/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class NewEmailViewController: BaseViewController{
    var newEmail = ""
    //var delegate: DataSendDelegate?

    let loginnotOk : UIImage = UIImage(named:"ic_okbtn")!
    
    @IBOutlet weak var unvalidLabel: UILabel!{
        didSet{
            unvalidLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var okBtn: UIButton!{
        didSet{
            okBtn.isEnabled = false
            //loginbtnPushed.setTitleColor(UIColor.black, for: .normal)
            okBtn.setImage(loginnotOk, for: UIControl.State.normal)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func okBtnPushed(_ sender: Any) {
        let params = ["reqType" : "0", "email": self.emailTextField.text!]
        MainDataManager().getnewEmail(self, params as [String : AnyObject])
        //self.navigationController!.pushViewController(NewPwViewController(), animated: true)
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -90 // Move view 150 points upward
        
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.frame = CGRect(x: 10, y: 40, width: self.view.bounds.size.width, height: 24)
        let image = UIImage(named: "ic_backbtn")
       
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        emailTextField.attributedPlaceholder = NSAttributedString(string: "메일주소@email.com",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        okBtn.isHidden = false
        //loginbtnPushed.isEnabled = true
        
        
        // Do any additional setup after loading the view.
    }

}
extension NewEmailViewController: UITextFieldDelegate{
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var email = false
        if let text = self.emailTextField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            newEmail = updatedText
            email = self.isValidEmail(emailStr: updatedText)
        }
        if email{
            okBtn.isEnabled = true
            //okBtn.setImage(loginOk, for: UIControl.State.normal)
            unvalidLabel.isHidden = true
        }else if(newEmail == ""){
            unvalidLabel.isHidden = true
        }else{
            unvalidLabel.isHidden = false
        }
        return true
    }
}
