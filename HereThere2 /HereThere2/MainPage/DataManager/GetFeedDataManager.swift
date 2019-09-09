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
        homeViewController.showIndicator()
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
                    }
                    homeViewController.dismissIndicator()
                case .failure:
                    homeViewController.dismissIndicator()
                    break
                }
            })
    }
}
