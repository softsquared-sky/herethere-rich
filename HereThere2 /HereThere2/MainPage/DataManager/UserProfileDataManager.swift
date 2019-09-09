//
//  UserProfileDataManager.swift
//  HereThere2
//
//  Created by 우소연 on 07/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class UserProfileDataManager : BaseViewController{
    //var delegate: DataSendDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getFeeds(_ myprofileViewController: MyProfileViewController) {
        myprofileViewController.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email)/profile", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: { (response: DataResponse<GetProfileResponse>) in
                switch response.result {
                case .success(let getprofileResponse):
                    if getprofileResponse.code == 102 {
                        let profileResponse = response.result.value
                        if let profiles = profileResponse?.profile{
                            for profile in profiles{
                                //myprofileViewController.profileImg.
                                myprofileViewController.nickName.text = profile.nickName
                                myprofileViewController.addr.text = profile.email
                                myprofileViewController.schoolName.text = profile.schoolName
                                myprofileViewController.statusMsg.text = profile.status
                            }
                        }
                        print(getprofileResponse.message!)
                        
                        // GetFeedResponse.message
                    } else {
                        //loginViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                    }
                    myprofileViewController.dismissIndicator()
                case .failure:
                    print(response)
                    myprofileViewController.dismissIndicator()
                    myprofileViewController.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
                    break
                    
                }
            })
    }
}
