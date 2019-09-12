//
//  RegFeedDataManager.swift
//  HereThere2
//
//  Created by 우소연 on 08/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper

class RegFeedDataManager : BaseViewController{
    //var delegate: DataSendDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func uploadFeed(_ postfeedViewController: PostFeedViewController){
        postfeedViewController.showIndicator()
        let url = URL(string: "http://52.79.198.51/posts")!
        let params = ["postPictureList":[],
                      "postLocation": postfeedViewController.arr2[0],
                      "postContents": postfeedViewController.contentTxtField.text!] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: {
            (response: DataResponse<LoginResponse>) in
            
            switch response.result {
            case .success(let feedResponse):
                
                if feedResponse.isSuccess == true{
                    //화면 전환 + 알라트
                    postfeedViewController.tableView.reloadData()
                    //postfeedViewController.presentAlert(title: "성공", message: "게시물을 등록했습니다.")
                    postfeedViewController.navigationController!.pushViewController(MainHomeViewController(), animated: true)
                }else{
                    self.presentAlert(title: "", message: feedResponse.message)
                }
                postfeedViewController.dismissIndicator()
                print("+++++++++++++++++++++++")
                print(response)
                break
            case .failure:
                postfeedViewController.dismissIndicator()
                print(response.error)
            }
        })
    }
}

