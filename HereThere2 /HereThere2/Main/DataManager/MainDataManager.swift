//
//  MainDataManager.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class MainDataManager : BaseViewController{
    //var delegate: DataSendDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var newEmail: String?
    var newPass: String?
    var nickName: String?
    var name: String?
    var birth: Int?
    
    func getpass(_ newpwViewController: NewPwViewController){
        newPass = newpwViewController.firstTxtField.text!
    }
    
    func getLogin(_ loginViewController: LoginViewController, _ parameter: [String: String]){
        
        Alamofire.request("\(self.appDelegate.baseUrl)/jwt", method: .post, parameters: parameter,encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: { (response: DataResponse<LoginResponse>) in
            switch response.result {
            case .success(let loginResponse):
                if loginResponse.code == 506{
                    print("dddddddddddddddddddd")
                    loginViewController.presentAlert(title: "", message: loginResponse.message)
                }
                print(response)
                break
            case .failure:
                 loginViewController.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
            }
        })
    }
    func getnewEmail(_ newemailViewController: NewEmailViewController, _ parameter: [String: AnyObject]){
       // let email = newemailViewController.emailTextField.text!
        //let params = ["reqType": "0", "email": email]
        Alamofire.request("\(self.appDelegate.baseUrl)/user", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: {
            (response: DataResponse<NewemailResponse>) in
            
            switch response.result {
            case .success(let newemailResponse):
                if newemailResponse.isSuccess == false{
                    print("dddddddddddddddddddd")
                    newemailViewController.presentAlert(title: "", message: newemailResponse.message)
                }
                print(response)
                break
            case .failure:
                /*(if let data =  newemailViewController.emailTextField.text{
                    self.delegate?.sendData(data: data)
                }*/
                self.newEmail = newemailViewController.emailTextField.text!
                newemailViewController.navigationController!.pushViewController(NewPwViewController(), animated: true)
               /* var statusCode = response.response?.statusCode
                if let error = response.result.error as? AFError {
                    statusCode = error._code // statusCode private
                    print(statusCode!)*/
            }
        })
    }
    func getnickName(_ newpersonalViewController: NewPersonalViewController){
        let nick = newpersonalViewController.nickTxt.text!
       let params = ["reqType": "1", "nickName": nick]
        Alamofire.request("\(self.appDelegate.baseUrl)/user", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: {
            (response: DataResponse<NewemailResponse>) in
            
            switch response.result {
            case .success(let newemailResponse):
                if newemailResponse.isSuccess == false{
                    newpersonalViewController.presentAlert(title: "", message: newemailResponse.message)
                }
                print(response)
                break
            case .failure:
                self.newPass = newpersonalViewController.nickTxt.text!
                self.birth = Int(newpersonalViewController.birthTxt.text!)
                self.name = newpersonalViewController.realnameTxt.text!
                newpersonalViewController.navigationController!.pushViewController(SchoolViewController(), animated: true)
            }
        })
    }

    func getNations(_ snationViewController: SNationViewController) {
        Alamofire.request("\(self.appDelegate.baseUrl)/location", method: .get).validate().responseObject(completionHandler: { (response: DataResponse<NationResponse>) in
                switch response.result {
                    
                case .success(let NationResponse):
                    print(response.result)
                    print(response)
                    if NationResponse.code == 100 {
                        let Nations = NationResponse.nations
                        
                        //snationViewController.arr2.append(Nations.location)
                    } else {
                        //snationViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                    }
                case .failure:
                    snationViewController.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
                }
            })
    }
    

    func getTutorials(_ mainViewController: MainViewController) {        
        Alamofire
            //.request("\(self.appDelegate.baseUrl)/tutorials", method: .get)
            .request("\(self.appDelegate.baseUrl)/ads", method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<TutorialResponse>) in
                switch response.result {
                case .success(let tutorialResponse):
                    if tutorialResponse.code == 100 {
                        mainViewController.titleLabel.text = tutorialResponse.message
                    } else {
                        mainViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                    }
                case .failure:
                    mainViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
            })
    }
}
