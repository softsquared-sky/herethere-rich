//
//  MainHomeViewController.swift
//  HereThere2
//
//  Created by 우소연 on 06/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//
import UIKit
import AlamofireObjectMapper
import Alamofire

class MainHomeViewController: BaseViewController, UITableViewDataSource {
    var imageView: UIImageView?
    var imageViews = [UIImageView](repeating: UIImageView(), count: 30)
    var feedImages: [UIImage] = []
    var count = 0
    var selected : Int?
    var index3 = [Int]()
    var current = 0
    var pictureNum = [Int]()
    var nickNamearr = [String]()
    var postNoarr = [Int]()
    var contentarr = [String]()
    var locationarr = [String]()
    var timeAgoarr = [String]()
    var picturearr = [String]()
    var heartarr = [Int]()
    var replyarr = [String]()
    var profilearr = [String]()
    let profileOk : UIImage = UIImage(named:"ic_mypageact")!
    let placeholder : UIImage = UIImage(named:"ic_blank")!
    let deprofile : UIImage = UIImage(named:"ic_profile")!
    let profilenotOk : UIImage = UIImage(named:"ic_mypage")!
    let nonheart : UIImage = UIImage(named:"ic_heart")!
    let heart : UIImage = UIImage(named:"ic_filledheart")!
    let homeOk : UIImage = UIImage(named:"ic_homeact")!
    let blank : UIImage = UIImage(named:"ic_smallblank")!
    var arr = [String]()
    @IBOutlet weak var hamSchool: UILabel!
    @IBOutlet weak var hamProfile: UIImageView!
    @IBOutlet weak var hamaddr: UILabel!
    @IBOutlet weak var hamnickName: UILabel!
    var empty = [Int](repeating: 0, count: 74)
    var a : Int?
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var MyprofileBtn: UIButton!{
        didSet{
            MyprofileBtn.setImage(profilenotOk, for: UIControl.State.normal)
        }
    }
    
    @IBAction func addFeed(_ sender: Any) {
        navigationController!.pushViewController(PostFeedViewController(), animated: true)
    }
    @IBAction func MyprofileBtn(_ sender: Any) {
        //MyprofileBtn.setImage(profileOk, for: UIControl.State.normal)
        navigationController!.pushViewController(MyProfileViewController(), animated: false)
        
    }
    
    @IBOutlet weak var HomeBtn: UIButton!{
        didSet{
            HomeBtn.setImage(homeOk, for: UIControl.State.normal)
        }
    }
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
    @IBAction func goProfile(_ sender: Any) {
        self.navigationController!.pushViewController(MyProfileViewController(), animated: true)
    }
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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    func getFeeds(inputArray:Array<String>) -> Array<String>{
        self.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/posts?current=\(self.current)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetFeedResponse>) in
                switch response.result {
                case .success(let getfeedResponse):
                    //성공을 했다
                    if getfeedResponse.code == 102 {
                        let feedResponse = response.result.value
                        if let feeds = feedResponse?.feeds{
                            for feed in feeds {
                                if feed.userPicture == nil{
                                    self.profilearr.append("none")
                                }else{
                                    self.profilearr.append(feed.userPicture!)
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
                                        self.feedImages.append(UIImage(named: "ic_blank")!)
                                    }else{
                                        i = i!+1
                                        let url = URL(string: picture.postPicture!)//imageurl가져오기
                                        let data = try? Data(contentsOf: url!)
                                        if let imageData = data {
                                            let image = UIImage(data: imageData)
                                            self.feedImages.append(image!)
                                        }else{
                                            self.feedImages.append(UIImage(named: "ic_placeholder")!)
                                        }
                                    }
                                }
                                self.pictureNum.append(i!)
                            }
                            
                            if self.pictureNum.count != self.index3.count{//각 게시물의 사진 시작점 구하기
                                var c2 : Int!
                                if self.current != 0{
                                   c2 = self.current - 1
                                }else{//current가 0일경우
                                    c2 = self.current
                                }
                                for p in c2..<self.pictureNum.count - 1{//1,2,1,2,1 /5 /0,1,3,4,6 5
                                    
                                    let answer = self.index3[p] + self.pictureNum[p]
                                    self.index3.append(answer)
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                    else if getfeedResponse.code == 103{
                        self.presentAlert(title: "알림", message: "마지막 페이지 입니다.")
                    }
                    self.dismissIndicator()
                case .failure:
                    self.dismissIndicator()
                    break
                }
            })
        return nickNamearr
    }
    
    func postHeart(heartpath: Int) -> Int{
        self.showIndicator()
        let url = URL(string: "http://52.79.198.51/heart")!
        let param2 = postNoarr[heartpath]
        let params = ["postNo" : param2]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: {
            (response: DataResponse<LoginResponse>) in
            
            switch response.result {
            case .success(let heartResponse):
                
                if heartResponse.isSuccess == true{
                    self.heartarr[heartpath] += 1
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
           
        }
        tableView.backgroundColor =
            UIColor.white
    }
    
    func getProfile(inputArray:Array<String>) -> Array<String> {
        self.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email!)/profile", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!]).validate().responseObject(completionHandler: { (response: DataResponse<GetProfileResponse>) in
            switch response.result {
            case .success(let getprofileResponse):
                if getprofileResponse.code == 102 {
                    let profileResponse = response.result.value
                    if let profiles = profileResponse?.profile{
                        for profile in profiles{
                            if profile.userPicture == nil{
                                self.hamProfile.image = self.deprofile
                            }else{
                                let url = URL(string: profile.userPicture!)//imageurl가져오기
                                let data = try? Data(contentsOf: url!)
                                if let imageData = data {
                                    let profileimage = UIImage(data: imageData)
                                    self.hamProfile.image = profileimage
                                    self.hamProfile.layer.borderColor = UIColor.gray.cgColor
                                    self.hamProfile.layer.borderWidth = 0.1
                                    self.hamProfile.layer.cornerRadius = self.hamProfile.frame.height/2
                                    self.hamProfile.clipsToBounds = true
                                }
                            }
                            self.hamnickName.text = profile.nickName
                            self.hamaddr.text = profile.email
                            self.hamSchool.text = profile.schoolName
                        }
                    }
                }
                self.dismissIndicator()
            case .failure:
                self.dismissIndicator()
                self.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
                break
                
            }
        })
        return arr
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.appDelegate.change == true{
            self.appDelegate.change = false
            replyarr[(self.appDelegate.indexpath2!.row)] = self.appDelegate.rep!
            tableView.reloadRows(at: [self.appDelegate.indexpath2!], with: UITableView.RowAnimation.none)
        }
        if self.appDelegate.pushed == true{
            self.appDelegate.pushed = false
            heartarr[self.appDelegate.indexpath2!.row] = heartarr[self.appDelegate.indexpath2!.row] + 1
            tableView.reloadRows(at: [self.appDelegate.indexpath2!], with: UITableView.RowAnimation.none)
        }
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.index3.isEmpty {
            self.index3.append(0)
        }
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "feedCell")
        self.navigationItem.title = "HERETHERE"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
        nickNamearr = getFeeds(inputArray: nickNamearr)
        arr = getProfile(inputArray: arr)
    }
    
    @objc func menuBtnTapped() {
        if(ishidden == false){//사라지기
            hamLeadingC.constant = -430
            hamTrailingC.constant = 430
            ishidden = true
            fakeLeadingC.constant = 430
            fakeTrailingC.constant = 0
        }else{
            ishidden = false
            hamLeadingC.constant = 0
            hamTrailingC.constant = 120
            fakeLeadingC.constant = 0
            fakeTrailingC.constant = 120
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }){ (animationComplete) in
        }
        
    }
}

extension MainHomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                 Cell.profileimg.layer.borderColor = UIColor.gray.cgColor
                 Cell.profileimg.layer.borderWidth = 0.1
                 Cell.profileimg.layer.cornerRadius = Cell.profileimg.frame.height/2
                 Cell.profileimg.clipsToBounds = true
            }
        }else{
            Cell.profileimg.image = deprofile
        }
        Cell.replyLbl.text = replyarr[indexPath.row]
        Cell.nicknameLbl.text = nickNamearr[indexPath.row]
        Cell.feedLbl.sizeToFit()
        Cell.feedLbl.text = contentarr[indexPath.row]
        Cell.locationLbl.text = locationarr[indexPath.row]
        Cell.timeagoLbl.text = timeAgoarr[indexPath.row]
        Cell.heartLbl.text = String(heartarr[indexPath.row])
       

        var mar = 30

        for index2 in index3[indexPath.row]..<index3[indexPath.row] + pictureNum[indexPath.row]{//picturearr에서의 각 게시물 시작 위치 부터 갯수만큼 돌기
            if feedImages[index2] == UIImage(named: "ic_blank"){
                self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
                imageView = UIImageView(image: blank)
                imageViews[index2] = imageView!
            }else{
                imageView = UIImageView(image: feedImages[index2])
                imageView!.frame = CGRect(x: mar, y: 120, width: 60, height: 60)
                Cell.addSubview(imageView!)
                Cell.bringSubviewToFront(imageView!)
                imageViews[index2] = imageView!
                mar = mar + 62
            }
        }
        let indexPath = IndexPath(item: indexPath.row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .top)
       
        if(empty[indexPath.row] == 0){//하트 계산해서 눌리는거 여부 확인
            Cell.heartBtn.setImage(nonheart, for: UIControl.State.normal)
        }else if(empty[indexPath.row] == 1){
            Cell.heartBtn.setImage(heart, for: UIControl.State.normal)
            Cell.heartBtn.isEnabled = true
        }
        Cell.heartBtn.addTarget(self, action:  #selector(connected(sender:)), for: .touchUpInside)
        Cell.heartBtn.tag = indexPath.row
       
        
        if indexPath.row == nickNamearr.count - 1 {//current page계산
            count = count + 1
            if count == 2{
                current = current + 5
                nickNamearr = getFeeds(inputArray: nickNamearr)
                count = 0
            }
        }
        
      return Cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        for ind in index3[indexPath.row]..<index3[indexPath.row] + pictureNum[indexPath.row]{
            imageViews[ind].image = nil
        }
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
        self.appDelegate.indexpath = postNoarr[indexPath.row]
        selected = indexPath.row
        self.appDelegate.indexpath2 = indexPath
        navigationController!.pushViewController(DetailFeedViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        for index2 in index3[indexPath.row]..<index3[indexPath.row] + pictureNum[indexPath.row]{
            if feedImages[index2] == UIImage(named: "ic_blank"){
                height = 160
            }else{
                height =  230
            }
        }
        return CGFloat(height)
    }
}

