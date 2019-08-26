//
//  personalViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class personalViewController: BaseViewController, UITextFieldDelegate {
    
    let loginnotOk : UIImage = UIImage(named:"ic_okbtn")!
    
    
    @IBOutlet weak var realnameTxt: UITextField!
    @IBOutlet weak var birthTxt: UITextField!
    @IBOutlet weak var nickTxt: UITextField!
  
    @IBOutlet weak var finBtn: UIButton!{
        didSet{
            finBtn.isEnabled = false
            finBtn.setImage(loginnotOk, for: UIControl.State.normal)
        }
    }

    func validateBirthday(birthStr:String) -> Bool {
        let birthdayRegEx = "[0-9]{6}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", birthdayRegEx)
        return predicate.evaluate(with: birthStr)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(validateBirthday(birthStr: birthTxt.text!)){
            finBtn.isEnabled = true
            //okBtn.setImage(loginOk, for: UIControl.State.normal)
            //unvalidLabel.isHidden = true
            
            
        }else{
            finBtn.isEnabled = false
            
        }
        print(birthTxt.text!,range.location, range.length)
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftColor = UIColor(red: 0/255.0, green: 159/255.0, blue: 229/255.0, alpha: 1.0)
        view.backgroundColor = swiftColor
        realnameTxt.attributedPlaceholder = NSAttributedString(string: "실명을 입력해주세요.",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        birthTxt.attributedPlaceholder = NSAttributedString(string: "생년월일을 입력해주세요. (ex: 960101)",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nickTxt.attributedPlaceholder = NSAttributedString(string: "사용할 닉네임을 입력해주세요.",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            finBtn.isHidden = false
        //loginbtnPushed.isEnabled = true
        birthTxt.delegate = self
        //secondTxtField.delegate = self
        // Do any additional setup after loading the view.
    }
    
}
