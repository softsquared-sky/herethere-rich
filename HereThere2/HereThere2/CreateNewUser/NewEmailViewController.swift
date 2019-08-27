//
//  NewEmailViewController.swift
//  HereThere2
//
//  Created by 우소연 on 27/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class NewEmailViewController: BaseViewController{
    
//    var delegate: SendDataDelegate?

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
        self.navigationController!.pushViewController(NewPwViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        emailTextField.attributedPlaceholder = NSAttributedString(string: "메일주소@email.com",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        okBtn.isHidden = false
        //loginbtnPushed.isEnabled = true
        emailTextField.delegate = self
        
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
        if(isValidEmail(emailStr: emailTextField.text!)){
            okBtn.isEnabled = true
            //okBtn.setImage(loginOk, for: UIControl.State.normal)
            unvalidLabel.isHidden = true
            
        }else{
            okBtn.isEnabled = false
            //loginbtnPushed.setTitleColor(UIColor.black, for: .normal)
            //okBtn.setImage(loginnotOk, for: UIControl.State.normal)
            unvalidLabel.isHidden = false
        }
        print(emailTextField.text!,range.location, range.length)
        return true
    }
}
