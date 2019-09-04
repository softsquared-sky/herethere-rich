//
//  NewPersonalViewController.swift
//  HereThere2
//
//  Created by 우소연 on 27/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class NewPersonalViewController: BaseViewController{
    
    @IBOutlet weak var birthUnvalidLabel: UILabel!{
        didSet{
           
                birthUnvalidLabel.isHidden = true
            
        }
    }
    
    
    @IBOutlet weak var nameUnvalidLabel: UILabel!{
        didSet{
                nameUnvalidLabel.isHidden = false
            
        }
    }
    let loginnotOk : UIImage = UIImage(named:"ic_okbtn")!
    var birthValid = false
    var name = ""
    var nick = ""
    var birth = ""
    
    @IBOutlet weak var unvalidLabel: UILabel!{
        didSet{
                unvalidLabel.isHidden = false
        }
    }
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
        MainDataManager().getnickName(self)
        //self.navigationController!.pushViewController(SchoolViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_backbtn")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_backbtn")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.frame = CGRect(x: 10, y: 40, width: self.view.bounds.size.width, height: 24)
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
        print("===================")
        
        //var password2 = false
        
        if textField == birthTxt{
            if let text = self.birthTxt.text, let textRange = Range(range, in: text){
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                birthValid = self.validateBirthday(birthStr: updatedText)
                if(birthValid){
                    birthUnvalidLabel.isHidden = true
                }
                if(!birthValid && birth != ""){
                    birthUnvalidLabel.isHidden = false
                    birthUnvalidLabel.text! = "생년월일이 형식에 맞지 않습니다."
                }else if(birth == ""){
                    birthUnvalidLabel.isHidden = true
                }else if(birthValid && birth != ""){
                    birthUnvalidLabel.isHidden = true
                }
                birth = updatedText
                //print(updatedText)
                print("birth: ")
                print(birth)
            }
        }else if textField == nickTxt{
            if let text = self.nickTxt.text, let textRange = Range(range, in: text){
                let nickText = text.replacingCharacters(in: textRange, with: string)
                nick = nickText
                if(nick == ""){
                    unvalidLabel.isHidden = false
                    unvalidLabel.text! = "닉네임을 입력해주세요."
                    
                }else{
                    unvalidLabel.isHidden = true
                }
                print("nick:" + nickText)
            }
        }else{
            if let text = self.realnameTxt.text, let textRange = Range(range, in: text){
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                name = updatedText
                if(name == ""){
                    nameUnvalidLabel.isHidden = false
                    nameUnvalidLabel.text! = "실명을 입력해주세요."
                }else{
                    nameUnvalidLabel.isHidden = true
                    
                }
                print("name: " + updatedText)
            }
        }
        if(birthValid && (nick != "") && (name != "")){
            finBtn.isEnabled = true
            unvalidLabel.text! = ""
        }else{
            finBtn.isEnabled = false
        }
        return true
    }
    
}
