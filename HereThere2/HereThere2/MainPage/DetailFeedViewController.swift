//
//  DetailFeedViewController.swift
//  HereThere2
//
//  Created by 우소연 on 08/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class DetailFeedViewController: BaseViewController, UITableViewDataSource, UITextFieldDelegate {
    var i : Int?
    let nonheart : UIImage = UIImage(named:"ic_heart")!
    let heart : UIImage = UIImage(named:"ic_filledheart")!
    var dum : Int?
    let deprofile : UIImage = UIImage(named:"ic_profile")!
    
    @IBOutlet weak var FeedView: UIView!
    
    @IBAction func heartBtn(_ sender: Any) {
        heartImg.setImage(heart, for: UIControl.State.normal)
        heartImg.isEnabled = true
        postHeart(heartpath: 1)
    }
    
    
    @IBAction func regBtn(_ sender: Any) {
        self.nickNamearr = [String]()
        self.contentarr = [String]()
        self.picturearr = [String]()
        self.timeAgoarr = [String]()
        dum = postReply(input: 1)
       // self.tableView.reloadData()
    }
    @IBOutlet weak var regBtn: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var heartLbl: UILabel!
    @IBOutlet weak var heartImg: UIButton!
    @IBOutlet weak var replyLbl: UILabel!
    @IBOutlet weak var replyImg: UIButton!
    var nickNamearr = [String]()
    var contentarr = [String]()
    var picturearr = [String]()
    var pictureNum : Int!
    var timeAgoarr = [String]()
    var changed = false
    var imageView: UIImageView?
    var imageViews = [UIImageView](repeating: UIImageView(), count: 30)
    var feedImages: [UIImage] = []

    let leftimage = UIImage(named: "ic_black_back")?.withRenderingMode(.alwaysOriginal)
    @IBOutlet weak var tableView: UITableView!
    
    var ishidden = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getFeeds(input: Int) -> Int{
        self.showIndicator()
        Alamofire
            .request("\(self.appDelegate.baseUrl)/post/\(self.appDelegate.indexpath)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DetailFeedResponse>) in
                switch response.result {
                case .success(let getfeedResponse):
                    if getfeedResponse.code == 102 {
                        let feedResponse = response.result.value
                        if let feeds = feedResponse?.feeds{
                            for feed in feeds {
                                if feed.userPicture != nil{
                                    let url = URL(string: feed.userPicture!)//imageurl가져오기
                                    let data = try? Data(contentsOf: url!)
                                    if let imageData = data {
                                        let profileimage = UIImage(data: imageData)
                                        self.profileImg.image = profileimage
                                        self.profileImg.layer.borderColor = UIColor.clear.cgColor
                                        self.profileImg.layer.borderWidth = 0.5
                                        self.profileImg.layer.cornerRadius = self.profileImg.frame.height/2
                                        self.profileImg.clipsToBounds = true
                                    }
                                }else{
                                    self.profileImg.image = self.deprofile
                                }
                                self.nickName.text! = feed.nickName
                                self.contents.text! = feed.postContents
                                self.location.text! = feed.postLocation
                                self.timeAgo.text! = feed.timeAgo
                                self.heartLbl.text! = String(feed.heart)
                                self.replyLbl.text! = feed.comment
                                self.i = 0
                                self.appDelegate.rep = self.replyLbl.text!

                                var mar = 16
                                
                                for picture in feed.pictureList!{
                                    if picture.postPicture == nil{
                                        //view 높이 맞추기
                                        break
                                    }else{
                                        self.i! = self.i! + 1
                                        let url = URL(string: picture.postPicture!)//imageurl가져오기
                                        let data = try? Data(contentsOf: url!)
                                        if let imageData = data {
                                            let image = UIImage(data: imageData)
                                            let imageView = UIImageView(image: image!)
                                            imageView.frame = CGRect(x: mar, y: 120, width: 60, height: 60)
                                            mar = mar + 62
                                            self.FeedView.addSubview(imageView)
                                            self.FeedView.bringSubviewToFront(imageView)
                                        }else{
                                            let image = UIImage(named: "ic_placeholder")
                                            let imageView = UIImageView(image: image)
                                            imageView.frame = CGRect(x: mar, y: 120, width: 60, height: 60)
                                            mar = mar + 62
                                            self.FeedView.addSubview(imageView)
                                            self.FeedView.bringSubviewToFront(imageView)
                                        }
                                       // self.picturearr.append(picture.postPicture!)
                                    }
                                }
                            }
                            
                        }
                    }
                    self.dismissIndicator()
                case .failure:
                    self.dismissIndicator()
                    break
                    //loginViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
                })
        return 1
    }
    func postReply(input: Int) -> Int{
        self.showIndicator()
        let params = ["postNo": self.appDelegate.indexpath ,"commentContents": textField.text!] as [String : Any]
        Alamofire
            .request("\(self.appDelegate.baseUrl)/comment", method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<LoginResponse>) in
                switch response.result {
                case .success(let replyResponse):
                    if replyResponse.isSuccess == true{
                        //화면 전환 + 알라트
                        self.dismissIndicator()
                        self.nickNamearr = [String]()
                        self.contentarr = [String]()
                        self.picturearr = [String]()
                        self.timeAgoarr = [String]()
                        self.textField.text! = ""
                        self.appDelegate.change = true
                        self.i = self.getReply(input: 1)
                    }else{
                        self.dismissIndicator()
                        self.presentAlert(title: "", message: replyResponse.message)
                    }
                    break
                case .failure:
                    self.dismissIndicator()
                }
            })
        return 1
    }
    func postHeart(heartpath: Int) -> Int{
        self.showIndicator()
        let url = URL(string: "http://52.79.198.51/heart")!
        let param2 = self.appDelegate.indexpath
        let params = ["postNo" : param2]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: {
            (response: DataResponse<LoginResponse>) in
            
            switch response.result {
            case .success(let heartResponse):
                
                if heartResponse.isSuccess == true{
                    //self.a = heartpath
                    
                    self.heartLbl.text! = String(Int(self.heartLbl.text!)! + 1)
                    self.appDelegate.pushed = true
                    self.tableView.reloadData()
                }else{
                    self.presentAlert(title: "", message: heartResponse.message)
                }
                self.dismissIndicator()
                break
            case .failure:
                self.dismissIndicator()
            }
        })
        return 1
    }
    func getReply(input: Int) -> Int{
        self.showIndicator()
        Alamofire
            .request("\(self.appDelegate.baseUrl)/comment?current=0&postNo=\(self.appDelegate.indexpath)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetReplyResponse>) in
                switch response.result {
                case .success(let getreplyResponse):
                    if getreplyResponse.code == 102 {
                        let replyResponse = response.result.value
                        if let replies = replyResponse?.reply{
                            for reply in replies {
                                self.nickNamearr.append(reply.nickName!)
                                self.contentarr.append(reply.commentContents!)
                                self.picturearr.append(reply.userPicture!)
                                self.timeAgoarr.append(reply.timeAgo!)
                            }
                            
                            self.tableView.reloadData()
                            self.dismissIndicator()
                            self.i = self.getFeeds(input: 1)
                            
                        }
                    }
                    self.dismissIndicator()
                case .failure:
                    self.dismissIndicator()
                        break
                }
            })
        return 1
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -255 // Move view 150 points upward
        
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    @objc private func leftbuttonPressed(_ sender: Any) { if sender is UIBarButtonItem {
        self.navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        i = getFeeds(input: 1)
        i = getReply(input: 1)
        self.tableView.separatorStyle = .none
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        let nibName = UINib(nibName: "ReplyTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "replyCell")
        self.navigationItem.title = "댓글"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftimage, style: .plain, target: self, action: #selector(leftbuttonPressed))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0);
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        let image = UIImage(named: "ic_black_back")
        
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
   
}
extension DetailFeedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nickNamearr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! ReplyTableViewCell
        let url = URL(string: picturearr[indexPath.row])//imageurl가져오기
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let profileimage = UIImage(data: imageData)
            Cell.profileImg.image = profileimage
            Cell.profileImg.layer.borderColor = UIColor.gray.cgColor
            Cell.profileImg.layer.borderWidth = 0.1
            Cell.profileImg.layer.cornerRadius = Cell.profileImg.frame.height/2
            Cell.profileImg.clipsToBounds = true
        }
        Cell.nickName.text = nickNamearr[indexPath.row]
        Cell.comment.text = contentarr[indexPath.row]
        Cell.timeAgo.text = timeAgoarr[indexPath.row]
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 59
    }
}
