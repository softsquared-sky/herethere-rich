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
    
    func getpass(_ newpwViewController: NewPwViewController){
        self.appDelegate.newPass = newpwViewController.first
        self.appDelegate.newPass2 = newpwViewController.second
    }
    func getschool(_ schoolViewController: SchoolViewController){
        self.appDelegate.schoolpicture = "http://naver.com/lemon.jpg"
        self.appDelegate.schoolname = schoolViewController.schoolTxt.text!
        //print( "SCHOOLNAME:" + self.appDelegate.schoolname!)
    }
    
    func getLogin(_ loginViewController: LoginViewController, _ parameter: [String: String]){
       // let url = URL(string: "\(self.appDelegate.baseUrl)/jwt")
       // let url = URL(string: "\(self.appDelegate.baseUrl)/jwt")!
        let url = URL(string: "http://52.79.198.51/jwt")!
        self.appDelegate.email = loginViewController.email
        print(parameter)
        let header = ["Content-Type": "application/json"]
        //loginViewController.showIndicator()
        Alamofire.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default, headers: header).validate().responseObject(completionHandler: { (response: DataResponse<GetLoginResponse>) in
            switch response.result {
                case .success(let loginResponse):
                    if loginResponse.code == 101{//성공시
                        let tokenResponse = loginResponse.result2 //success이하 값 가져오기
                        print(loginResponse.code!)
                        print(tokenResponse)
                        //print(tokenResponse?.code!)//code값 = 101
                        //let token = tokenResponse?.result2
                        self.appDelegate.myjwt = tokenResponse?.jwt
                        print(self.appDelegate.myjwt!)
                        loginViewController.dismissIndicator()
                        loginViewController.navigationController!.pushViewController(MainHomeViewController(), animated: true)
                        print("화면전환됨 =")
                    }else{
                        loginViewController.dismissIndicator()
                        loginViewController.presentAlert(title: "", message: loginResponse.message)
                        
                    }
                    break
                case .failure:
                    loginViewController.dismissIndicator()
                    print(response.error)
                    loginViewController.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
                }
        })
    }
    func getnewEmail(_ newemailViewController: NewEmailViewController, _ parameter: [String: AnyObject]){
        newemailViewController.showIndicator()
         let url = URL(string: "http://52.79.198.51/user")!
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: {
            (response: DataResponse<NewemailResponse>) in
            
            switch response.result {
            case .success(let newemailResponse):
                if newemailResponse.isSuccess == false{
                    newemailViewController.presentAlert(title: "", message: newemailResponse.message)
                }
                newemailViewController.dismissIndicator()
                print(response)
                break
            case .failure:
                print(response.error)
                //self.newEmail = newemailViewController.newEmail
                self.appDelegate.newEmail = newemailViewController.emailTextField.text!
                print("self.newemail= " + self.appDelegate.newEmail!)
                newemailViewController.dismissIndicator()
                newemailViewController.navigationController!.pushViewController(NewPwViewController(), animated: true)
            }
        })
    }
    func getnickName(_ newpersonalViewController: NewPersonalViewController){
        let nick = newpersonalViewController.nick
        let params = ["reqType": "1", "nickName": nick]
        newpersonalViewController.showIndicator()
        let url = URL(string: "http://52.79.198.51/user")!
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: {
            (response: DataResponse<NewemailResponse>) in
            
            switch response.result {
            case .success(let newemailResponse):
                if newemailResponse.isSuccess == false{
                    newpersonalViewController.presentAlert(title: "", message: newemailResponse.message)
                }
                newpersonalViewController.dismissIndicator()
                print(response)
                break
            case .failure:
                print(response)
                self.appDelegate.nickName = newpersonalViewController.nick
                self.appDelegate.birth = Int(newpersonalViewController.birth)
                self.appDelegate.name = newpersonalViewController.name
                print("self.newemail= " + self.appDelegate.newEmail!)
                newpersonalViewController.dismissIndicator()
                newpersonalViewController.navigationController!.pushViewController(SchoolViewController(), animated: true)
            }
        })
    }
    //국가 선택해서 [1, 3]만들기
    func postnation(_ snationViewController: SNationViewController){
        for i in 0..<snationViewController.empty.count{
            if snationViewController.empty[i] == 1{
                //nation.append( "{ locationNo: \(i+1) }" )
            }
        }
        print(self.appDelegate.nation)
        //snationViewController.navigationController!.pushViewController(FinishViewController(), animated: true)
    }
    //회원가입 누르기
    func getnewUser(_ snationViewController: SNationViewController){
        print("self.newEmail==============" + self.appDelegate.newEmail!)
        print("self.newEmail==============" + self.appDelegate.newPass!)
        print("self.newEmail==============" + self.appDelegate.newPass2!)
        print("self.newEmail==============" + self.appDelegate.name!)
        print(self.appDelegate.birth!)
        print("self.newEmail==============" + self.appDelegate.schoolname!)
        print("self.newEmail==============" + self.appDelegate.schoolpicture!)
        
        var params = ["reqType": "2",
                      "email": self.appDelegate.newEmail!,
                      "password": self.appDelegate.newPass!,
                      "rePassword": self.appDelegate.newPass2!,
                      "name": self.appDelegate.name!,
                      "birth": self.appDelegate.birth!,
                      "nickName": self.appDelegate.nickName!,
                      "schoolPicture": self.appDelegate.schoolpicture!,
                      "schoolName": self.appDelegate.schoolname!,
                      "locationList": []] as [String : Any]
        for i in 0..<snationViewController.empty.count{
            //print()
            if snationViewController.empty[i] == 1{
                let item: [String: Any] = [
                    "locationNo": i+1
                ]
                var existingItems = params["locationList"] as? [[String: Any]] ?? [[String: Any]]()
                existingItems.append(item)
                //nation.append(i+1)
                params["locationList"] = existingItems
            }
        }
        print(params)
        snationViewController.showIndicator()
        let url = URL(string: "http://52.79.198.51/user")!
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: {
            (response: DataResponse<LoginResponse>) in
            
            switch response.result {
            case .success(let newuserResponse):
                if newuserResponse.isSuccess == false{
                    snationViewController.presentAlert(title: "", message: newuserResponse.message)//통신 성공, 오류코드 발생
                }else{
                    snationViewController.dismissIndicator()
                    snationViewController.navigationController!.pushViewController(FinishViewController(), animated: true)//통신성공, 성공
                }
                print(response)
                //snationViewController.dismissIndicator()
                break
            case .failure:
                print(response)
                snationViewController.dismissIndicator()
                snationViewController.presentAlert(title: "", message: "오류가 발생했습니다.")//통신 실패
                
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
