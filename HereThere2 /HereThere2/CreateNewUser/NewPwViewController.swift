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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
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
        firstTxtField.delegate = self
        secondTxtField.delegate = self
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
        if(validatePassword(passStr: firstTxtField.text!) && (firstTxtField.text! == secondTxtField.text!)){
            okpwBtn.isEnabled = true
            unvalidLabel.text! = ""
           
        }else{
            if(validatePassword(passStr: firstTxtField.text!) == false){
                unvalidLabel.text! = "영문과 숫자조합으로 만들어주세요."
            }else if(firstTxtField.text! != secondTxtField.text!){
                unvalidLabel.text! = "비밀번호가 일치하지 않습니다."
            }
            okpwBtn.isEnabled = false
            
        }
        print(firstTxtField.text!,range.location, range.length)
        return true
    }
}