//
//  NewPwViewController.swift
//  HereThere2
//
//  Created by 우소연 on 27/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class NewPwViewController: BaseViewController{
    
    let loginnotOk : UIImage = UIImage(named:"ic_okbtn")!
    var first = ""
    var second = ""
    var password = false
    @IBOutlet weak var unvalidLabel: UILabel!
    
    @IBOutlet weak var firstTxtField: UITextField!
    //var delegate: SendDataDelegate?

    @IBOutlet weak var secondTxtField: UITextField!
    
    @IBOutlet weak var okpwBtn: UIButton!{
        didSet{
            okpwBtn.isEnabled = false
            okpwBtn.setImage(loginnotOk, for: UIControl.State.normal)
        }
    }
    @IBAction func okpwBtnPushed(_ sender: Any) {
        MainDataManager().getpass(self)
        self.navigationController!.pushViewController(NewPersonalViewController(), animated: true)
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -90 // Move view 150 points upward
        
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTxtField.delegate = self
        secondTxtField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_backbtn")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_backbtn")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.frame = CGRect(x: 10, y: 40, width: self.view.bounds.size.width, height: 24)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        firstTxtField.attributedPlaceholder = NSAttributedString(string: "영문, 숫자를 포함한 6-10자리",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        secondTxtField.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        okpwBtn.isHidden = false
        //loginbtnPushed.isEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
}
extension NewPwViewController: UITextFieldDelegate {
    
    func validatePassword(passStr:String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{6,10}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: passStr)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("===================")
        
        //var password2 = false
        
        if textField == firstTxtField{
            if let text = self.firstTxtField.text, let textRange = Range(range, in: text){
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                password = self.validatePassword(passStr: updatedText)
                first = updatedText
                print(updatedText)
            }
        }else{
            if let passsecond = self.secondTxtField.text, let passsecondRange = Range(range, in: passsecond){
                let updatedPasssecond = passsecond.replacingCharacters(in: passsecondRange, with: string)
                //password2 = self.validatePassword(passStr: updatedPasssecond)
                second = updatedPasssecond
                print(updatedPasssecond)
            }
        }
        print("first:" + first)
        print("++++")
        print("second:" + second)
       
        if password && (first == second){
            okpwBtn.isEnabled = true
            unvalidLabel.text! = ""
        }else if(!password && first != ""){//false 비어있지 않는경우
            unvalidLabel.text! = "영문과 숫자조합으로 만들어주세요."
        }else if(first != second && first != "" && second != ""){// 같지 않고 둘다 비어있지 않은 경우
             unvalidLabel.text! = "비밀번호가 일치하지 않습니다."
        }else if((first == "") && (second == "")){//둘다 비어있는 경우
            unvalidLabel.text! = ""
        }
        return true
    }
}
