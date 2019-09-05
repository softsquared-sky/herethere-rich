//
//  GetFeedDataManager.swift
//  HereThere2
//
//  Created by 우소연 on 04/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class GetFeedDataManager : BaseViewController{
    //var delegate: DataSendDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getFeeds(_ homeViewController: HomeViewController) {
        Alamofire
            //.request("\(self.appDelegate.baseUrl)/tutorials", method: .get)
            .request("\(self.appDelegate.baseUrl)/posts?current", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetFeedResponse>) in
                switch response.result {
                case .success(let getfeedResponse):
                    if getfeedResponse.code == 100 {
                        print(getfeedResponse.message)
                        // GetFeedResponse.message
                    } else {
                        //loginViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                    }
                
                case .failure:
                    break
                    //loginViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
            })
    }
    /*
    func getNation(inputArray:Array<String>) -> Array<String>{
        Alamofire.request("\(self.appDelegate.baseUrl)/location", method: .get).validate().responseObject(completionHandler: { (response: DataResponse<NationResponse>) in
            switch response.result {
                
            case .success(let NationResponse):
                if NationResponse.code == 102 {
                    let nationResponse = response.result.value
                    print(nationResponse?.code)
                    if let nations = nationResponse?.nations {
                        for nation in nations {
                            self.arr2.append(nation.location!)
                            print(nation.locationNo)
                        }
                        for i in 0..<self.arr2.count{
                            print(self.arr2[i])
                        }
                        self.tableView.reloadData()
                        
                    }
                } else {
                    //snationViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                }
            case .failure:
                self.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
            }
        })
        return arr2
    }
    func getLogin(_ loginViewController: LoginViewController, _ parameter: [String: String]){
        
        Alamofire.request("\(self.appDelegate.baseUrl)/jwt", method: .post, parameters: parameter,encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<600).responseObject(completionHandler: { (response: DataResponse<Login2Response>) in
            switch response.result {
            case .success(let loginResponse):
                if loginResponse.code == 101{
                    let tokenResponse = response.result.value
                    print(tokenResponse?.code)
                    if let tokens = tokenResponse?.result {
                        for token in tokens {
                            self.appDelegate.myjwt = token.jwt
                        }
                    }
                    //화면 전환
                    //loginViewController.navigationController!.pushViewController(homeViewController(), animated: true)
                }else{
                    loginViewController.presentAlert(title: "", message: loginResponse.message)
                }
                print(response)
                break
            case .failure:
                print(response)
                loginViewController.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
            }
        })
    }
    func getnickName(_ newpersonalViewController: NewPersonalViewController){
        let nick = newpersonalViewController.nick
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
                print(response)
                self.appDelegate.nickName = newpersonalViewController.nick
                self.appDelegate.birth = Int(newpersonalViewController.birth)
                self.appDelegate.name = newpersonalViewController.name
                print("self.newemail= " + self.appDelegate.newEmail!)
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
        
        //print(nation)
        /* let nation1 = ["locationNo" : "1"]
         let nation2 = ["locationNo" : "2"]
         var bignation = [[String: Any]]()
         bignation.append(nation1)
         bignation.append(nation2)
         print(bignation)*/
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
        Alamofire.request("\(self.appDelegate.baseUrl)/user", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: {
            (response: DataResponse<LoginResponse>) in
            
            switch response.result {
            case .success(let newuserResponse):
                if newuserResponse.isSuccess == false{
                    snationViewController.presentAlert(title: "", message: newuserResponse.message)//통신 성공, 오류코드 발생
                }else{
                    snationViewController.navigationController!.pushViewController(FinishViewController(), animated: true)//통신성공, 성공
                }
                print(response)
                break
            case .failure:
                print(response)
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
    }*/
}
