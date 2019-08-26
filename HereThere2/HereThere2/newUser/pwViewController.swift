//
//  pwViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class pwViewController: BaseViewController, UITextFieldDelegate {
    
    let loginnotOk : UIImage = UIImage(named:"ic_okbtn")!

    
    @IBOutlet weak var firstTxtField: UITextField!
    //var delegate: SendDataDelegate?
    
    @IBOutlet weak var secondTxtField: UITextField!
    
    @IBOutlet weak var okpwBtn: UIButton!{
        didSet{
            okpwBtn.isEnabled = false
            okpwBtn.setImage(loginnotOk, for: UIControl.State.normal)
        }
    }
    func validatePassword(passStr:String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{6,10}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: passStr)
    }
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(validatePassword(passStr: firstTxtField.text!) && (firstTxtField.text! == secondTxtField.text!)){
            okpwBtn.isEnabled = true
            //okBtn.setImage(loginOk, for: UIControl.State.normal)
            //unvalidLabel.isHidden = true
            
            
        }else{
            okpwBtn.isEnabled = false
            
        }
        print(firstTxtField.text!,range.location, range.length)
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftColor = UIColor(red: 0/255.0, green: 159/255.0, blue: 229/255.0, alpha: 1.0)
        view.backgroundColor = swiftColor
        firstTxtField.attributedPlaceholder = NSAttributedString(string: "영문, 숫자를 포함한 6-10자리",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        secondTxtField.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        okpwBtn.isHidden = false
        //loginbtnPushed.isEnabled = true
        firstTxtField.delegate = self
        secondTxtField.delegate = self
        // Do any additional setup after loading the view.
    }
    
}
