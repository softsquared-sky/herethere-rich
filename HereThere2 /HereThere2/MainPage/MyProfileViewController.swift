//
//  MyProfileViewController.swift
//  HereThere2
//
//  Created by 우소연 on 06/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class MyProfileViewController: BaseViewController, UITableViewDataSource {
   // var arr = [String]()
    @IBAction func addBtn(_ sender: Any) {
        navigationController!.pushViewController(PostFeedViewController(), animated: true)
    }
    let nonheart : UIImage = UIImage(named:"ic_heart")!
    let heart : UIImage = UIImage(named:"ic_filledheart")!
      var empty = [Int](repeating: 0, count: 74)
    var b  = 0
    var count = 0
    var picturearr = [String]()
    var index3 = [Int]()
    var pictureNum = [Int]()
    var postNoarr = [Int]()
    var profilearr = [String]()
    var current = 0
    let deprofile : UIImage = UIImage(named:"ic_profile")!
    let homenotOk : UIImage = UIImage(named:"ic_home")!
    let homeOk : UIImage = UIImage(named:"ic_homeact")!
    let profileOk : UIImage = UIImage(named:"ic_mypageact")!
    
    @IBOutlet weak var goHomeBtn: UIButton!{
        didSet{
            goHomeBtn.setImage(homenotOk, for: UIControl.State.normal)
        }
    }
    @IBAction func goHomeBtn(_ sender: Any) {
        
       // goHomeBtn.setImage(homeOk, for: UIControl.State.normal)
        navigationController!.pushViewController(MainHomeViewController(), animated: false)
    }
    @IBOutlet weak var MyprofileBtn: UIButton!{
        didSet{
            MyprofileBtn.setImage(profileOk, for: UIControl.State.normal)
        }
    }
    
    @IBOutlet weak var nonLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var addr: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var statusMsg: UILabel!
    @IBOutlet weak var hamProfileimg: UIImageView!
    @IBOutlet weak var hamnickName: UILabel!
    @IBOutlet weak var hamaddr: UILabel!
    @IBOutlet weak var hamSchool: UILabel!
    
    @IBAction func presshamProfile(_ sender: Any) {
        // 상세 프로필로 전환
        navigationController!.pushViewController(MyProfileViewController(), animated: true)
    }
    
    
    var arr = [String]()
    var nickNamearr = [String]()
    var contentarr = [String]()
    var locationarr = [String]()
    var timeAgoarr = [String]()
    var heartarr = [Int]()
    var replyarr = [String]()
   // let profileOk : UIImage = UIImage(named:"ic_mypageact")!
    //let profilenotOk : UIImage = UIImage(named:"ic_mypage")!
    @IBOutlet weak var fakeTrailingC: NSLayoutConstraint!{
        didSet{
            fakeTrailingC.constant = 0
        }
    }
    @IBOutlet weak var fakeLeadingC: NSLayoutConstraint!{
        didSet{
            fakeLeadingC.constant = 430
            
        }
    }
    @IBOutlet weak var fakeview: UIView!{
        didSet{
            fakeview.backgroundColor =
                UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    var ishidden = false
    @IBOutlet var main: UIView!
    @IBOutlet weak var hamTrailingC: NSLayoutConstraint!{
        didSet{
            hamTrailingC.constant = 430
        }
    }
    @IBOutlet weak var hamLeadingC: NSLayoutConstraint!{
        didSet{
            hamLeadingC.constant = -430
        }
    }
    @IBAction func logoutbtn(_ sender: Any) {
        self.navigationController!.pushViewController(LogoutViewController(), animated: true)
    }
    let imgIcon = UIImage(named: "ic_hammenu")?.withRenderingMode(.alwaysOriginal)
    
    @IBAction func dismissbtn(_ sender: Any) {
        hamLeadingC.constant = -430
        hamTrailingC.constant = 430
        ishidden = true
        fakeLeadingC.constant = 430
        fakeTrailingC.constant = 0
        ishidden = true
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }){ (animationComplete) in
            print("the animation complete")
        }
        tableView.backgroundColor =
            UIColor.white
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getProfile(inputArray:Array<String>) -> Array<String> {
        self.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email!)/profile", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: { (response: DataResponse<GetProfileResponse>) in
            switch response.result {
                
            case .success(let getprofileResponse):
                
                if getprofileResponse.code == 102 {
                    let profileResponse = response.result.value
                    if let profiles = profileResponse?.profile{
                        for profile in profiles{
                            //myprofileViewController.profileImg.
                            if profile.userPicture != nil{
                                let url = URL(string: profile.userPicture!)//imageurl가져오기
                                let data = try? Data(contentsOf: url!)
                                if let imageData = data {
                                    let profileimage = UIImage(data: imageData)
                                    self.hamProfileimg.image = profileimage
                                    self.profileImg.image = profileimage
                                }
                            }else{
                                self.profileImg.image = self.deprofile
                                self.hamProfileimg.image = self.deprofile
                            }
                            self.hamnickName.text! = profile.nickName
                            self.hamaddr.text! = profile.email
                            self.hamSchool.text! = profile.schoolName
                            self.nickName.text = profile.nickName
                            self.addr.text = profile.email
                            self.schoolName.text = profile.schoolName
                            self.statusMsg.text = profile.status
                        }
                    }
                    self.dismissIndicator()
                    print(getprofileResponse.message!)
                    
                    // GetFeedResponse.message
                } else {
                    //loginViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                }
                
            case .failure:
                self.dismissIndicator()
                print(response)
                break
                self.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
            }
        })
        return arr
    }
    func getFeeds(inputArray:Array<String>) -> Array<String>{
        //func getFeeds() {
        self.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email!)/posts?current=\(self.current)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetFeedResponse>) in
                switch response.result {
                case .success(let getfeedResponse):
                    if getfeedResponse.code == 102 {
                        let feedResponse = response.result.value
                        if let feeds = feedResponse?.feeds{
                            for feed in feeds {
                                //self.nickNamearr.append(feed?.nickName!)
                                if feed.userPicture == nil{
                                    self.profilearr.append("none")
                                }else{
                                    self.profilearr.append(feed.userPicture!)
                                    //print("none")
                                }
                                self.postNoarr.append(feed.postNo!)
                                self.nickNamearr.append(feed.nickName!)
                                self.contentarr.append(feed.postContents!)
                                self.locationarr.append(feed.postLocation!)
                                self.timeAgoarr.append(feed.timeAgo!)
                                self.heartarr.append(feed.heart!)
                                self.replyarr.append(feed.comment!)
                                var i : Int?
                                i = 0
                                for picture in feed.pictureList!{
                                    if picture.postPicture == nil{
                                        i = 1
                                        self.picturearr.append("none")
                                        //print("none")
                                    }else{
                                        i = i!+1
                                        self.picturearr.append(picture.postPicture!)
                                    }
                                }
                                self.pictureNum.append(i!)
                            }
                            if self.pictureNum.count != self.index3.count{
                                for p in 0..<self.pictureNum.count{//1,2,1,2,1 /5 /0,1,3,4,6
                                    let answer = self.index3[p] + self.pictureNum[p]
                                    self.index3.append(answer)
                                }
                            }
                            print("777777777")
                            print(self.picturearr)
                            //self.tableView.reloadData()
                        }
                        self.tableView.reloadData()
                        //print(feedResponse!)
                    }
                    else if getfeedResponse.code == 103{
                        //self.tableView.reloadData()
                        self.presentAlert(title: "알림", message: "마지막 페이지 입니다.")
                    }
                    self.dismissIndicator()
                case .failure:
                    self.dismissIndicator()
                    break
                    //loginViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
                print(response)
            })
        return arr
    }
    func postHeart(heartpath: Int) -> Int{
        self.showIndicator()
        let url = URL(string: "http://52.79.198.51/heart")!
        let param2 = postNoarr[heartpath]
        print(param2)
        let params = ["postNo" : param2]
        print(params)
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: {
            (response: DataResponse<LoginResponse>) in
            
            switch response.result {
            case .success(let heartResponse):
                
                if heartResponse.isSuccess == true{
                    //self.a = heartpath
                    self.heartarr[heartpath] += 1
                    self.tableView.reloadData()
                }else{
                    self.presentAlert(title: "", message: heartResponse.message)
                }
                print(response)
                self.dismissIndicator()
                break
            case .failure:
                print(response.error)
                self.dismissIndicator()
            }
        })
        return 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.index3.isEmpty {
            self.index3.append(0)
        }
        arr = getProfile(inputArray: arr)
        //nickNamearr = getFeeds(inputArray: nickNamearr)
       
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "feedCell")
        self.navigationItem.title = "마이 프로필"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
        arr = getFeeds(inputArray: arr)
        print("=====================")
    }
    
    @objc func menuBtnTapped() {
        if(ishidden == false){//사라지기
            hamLeadingC.constant = -430
            hamTrailingC.constant = 430
            ishidden = true
            fakeLeadingC.constant = 430
            fakeTrailingC.constant = 0
            print("show")
        }else{
            ishidden = false
            hamLeadingC.constant = 0
            hamTrailingC.constant = 120
            //tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            fakeLeadingC.constant = 0
            fakeTrailingC.constant = 120
            //fakeview.backgroundColor =
            //  UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }){ (animationComplete) in
            print("====")
        }
        
    }
}
extension MyProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nonLabel.isHidden = true
        return nickNamearr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        
        if profilearr[indexPath.row] != "none"{
            let url = URL(string: profilearr[indexPath.row])//imageurl가져오기
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let profileimage = UIImage(data: imageData)
                Cell.profileimg.image = profileimage
            }
        }else{
            Cell.profileimg.image = deprofile
        }
        var mar = 50
        //1,1,1,1,1,5,5
        //0,1,2,3,4,5,10
        let con = index3[indexPath.row] + pictureNum[indexPath.row]
        for index2 in index3[indexPath.row]..<con{
            //3..<3+1
            if picturearr[index2] == "none"{
                break
            }
            //print("imageurl:" + picturearr[index2] )
            let url = URL(string: picturearr[index2])//imageurl가져오기
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                print("Igotit")
                let image = UIImage(data: imageData)
                let imageView = UIImageView(image: image!)
                imageView.frame = CGRect(x: mar, y: 120, width: 60, height: 60)
                Cell.addSubview(imageView)
                Cell.bringSubviewToFront(imageView)
                mar = mar + 70
                //print("Igotit")
            }
        }
        // b = b + pictureNum[indexPath.row]
        Cell.nicknameLbl.text = nickNamearr[indexPath.row]
        Cell.feedLbl.sizeToFit()
        Cell.feedLbl.text = contentarr[indexPath.row]
        Cell.locationLbl.text = locationarr[indexPath.row]
        Cell.timeagoLbl.text = timeAgoarr[indexPath.row]
        Cell.heartLbl.text = String(heartarr[indexPath.row])
        Cell.replyLbl.text = replyarr[indexPath.row]
        
        if(empty[indexPath.row] == 0){
            Cell.heartBtn.setImage(nonheart, for: UIControl.State.normal)
        }else if(empty[indexPath.row] == 1){
            Cell.heartBtn.setImage(heart, for: UIControl.State.normal)
            Cell.heartBtn.isEnabled = true
        }
        Cell.heartBtn.addTarget(self, action:  #selector(connected(sender:)), for: .touchUpInside)
        Cell.heartBtn.tag = indexPath.row
        print(indexPath.row)
        //print(nickNamearr.count)
        if indexPath.row == nickNamearr.count - 1 {
            count = count + 1
            if count == 2{
                print("ok")
                current = current + 5
                //self.tableView.reloadData()
                nickNamearr = getFeeds(inputArray: nickNamearr)
                count = 0
            }
        }
        return Cell
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        sender.setImage(heart, for: UIControl.State.normal)
        sender.isEnabled = true
        postHeart(heartpath: buttonTag)
        empty[buttonTag] = 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        print("선택된 cell 번호")
        print(postNoarr[indexPath.row])
        self.appDelegate.indexpath = postNoarr[indexPath.row]
        navigationController!.pushViewController(DetailFeedViewController(), animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        for index2 in index3[indexPath.row]..<index3[indexPath.row] + pictureNum[indexPath.row]{
            if picturearr[index2] == "none"{
                height = 160
            }else{
                height =  230
            }
        }
        return CGFloat(height)
    }
}
    

