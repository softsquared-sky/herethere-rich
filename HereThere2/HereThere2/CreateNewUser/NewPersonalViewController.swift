//
//  NewPersonalViewController.swift
//  HereThere2
//
//  Created by 우소연 on 27/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class NewPersonalViewController: BaseViewController{
    
    let loginnotOk : UIImage = UIImage(named:"ic_okbtn")!
  
    @IBOutlet weak var unvalidLabel: UILabel!
    @IBOutlet weak var realnameTxt: UITextField!
    @IBOutlet weak var birthTxt: UITextField!
    @IBOutlet weak var nickTxt: UITextField!
    @IBOutlet weak var finBtn: UIButton!{
        didSet{
            finBtn.isEnabled = false
            finBtn.setImage(loginnotOk, for: UIControl.State.normal)
        }
    }
    @IBAction func finBtnPushed(_ sender: Any) {
        self.navigationController!.pushViewController(SchoolViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        realnameTxt.attributedPlaceholder = NSAttributedString(string: "실명을 입력해주세요.",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        birthTxt.attributedPlaceholder = NSAttributedString(string: "생년월일을 입력해주세요. (ex: 960101)",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nickTxt.attributedPlaceholder = NSAttributedString(string: "사용할 닉네임을 입력해주세요.",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        finBtn.isHidden = false
        //loginbtnPushed.isEnabled = true
        birthTxt.delegate = self
        realnameTxt.delegate = self
        nickTxt.delegate = self
        //secondTxtField.delegate = self
        // Do any additional setup after loading the view.
    }
    
}
extension NewPersonalViewController: UITextFieldDelegate {
    func validateBirthday(birthStr:String) -> Bool {
        let birthdayRegEx = "[0-9]{6}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", birthdayRegEx)
        return predicate.evaluate(with: birthStr)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let first = realnameTxt.text!
        let second = nickTxt.text!
        if(validateBirthday(birthStr: birthTxt.text!) && (first.isEmpty == false) && (second.isEmpty == false)){
            finBtn.isEnabled = true
            unvalidLabel.text! = ""
        }else{
            if(validateBirthday(birthStr: birthTxt.text!) == false){
                unvalidLabel.text! = "생년월일이 형식에 맞지 않습니다."
            }else if(first.isEmpty){
                unvalidLabel.text! = "실명을 입력해주세요."
            }else if(second.isEmpty){
                unvalidLabel.text! = "닉네임을 입력해주세요."
            }
            finBtn.isEnabled = false
        }
        print(birthTxt.text!,range.location, range.length)
        return true
    }
    
}
