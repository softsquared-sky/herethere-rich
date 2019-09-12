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

class MyProfileViewController: BaseViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   // var arr = [String]()
    @IBAction func addBtn(_ sender: Any) {
        navigationController!.pushViewController(PostFeedViewController(), animated: true)
    }
    @IBOutlet weak var mycollView: UICollectionView!
    
    @IBAction func pressGallery(_ sender: Any) {
        self.tableView.isHidden = true
        print("pressed")
        self.mycollView.isHidden = false
    }
    
    @IBAction func pressWord(_ sender: Any) {
        self.tableView.isHidden = false
        self.mycollView.isHidden = true
    }
     var imageView: UIImageView?
    let blank : UIImage = UIImage(named:"ic_smallblank")!
    var imageViews = [UIImageView](repeating: UIImageView(), count: 30)
    var imageViews2 = [UIImageView](repeating: UIImageView(), count: 30)
    var feedImages: [UIImage] = []
     var feedImages2: [UIImage] = []
    let nonheart : UIImage = UIImage(named:"ic_heart")!
    let heart : UIImage = UIImage(named:"ic_filledheart")!
      var empty = [Int](repeating: 0, count: 74)
    var b  = 0
    var count = 0
    var count2 = 0
    var current2 = 0
    var picturearr = [String]()
    var imagearr = [String]()
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
    
    var i2 = 0
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
    func getImages(inputArray:Array<String>) -> Array<String>{
         self.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email!)/posts/pictures?current=\(self.current2)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetImagesDataResponse>) in
                switch response.result {
                case .success(let getimageResponse):
                    if getimageResponse.code == 102 {
                        let imageResponse = response.result.value
                        if let images = imageResponse?.images{
                            for image in images {
                                /*if image.postPicture == nil{
                                    self.i = 0
                                    self.feedImages2.append(UIImage(named: "ic_blank")!)
                                }else{*/
                                    self.i2 = self.i2 + 1
                                    let url = URL(string: image.postPicture!)//imageurl가져오기
                                    let data = try? Data(contentsOf: url!)
                                    if let imageData = data {
                                        //print("Igotit")
                                        let image = UIImage(data: imageData)
                                        self.feedImages2.append(image!)
                                    }else{
                                        self.feedImages2.append(UIImage(named: "ic_placeholder")!)
                                    }
                                //}
                                //self.imagearr.append(image.postPicture!)
                                //print("none")
                            }
                            print("i7")
                            print(self.i2)
                            //print("777777777")
                            //print(self.imagearr)
                        }
                        self.mycollView.reloadData()
                    }
                    else if getimageResponse.code == 106{
                        self.presentAlert(title: "알림", message: "게시물이 없습니다.")
                    }
                self.dismissIndicator()
                case .failure:
                     self.dismissIndicator()
                    break
                    //loginViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
                print(response)
            })
        return imagearr
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
                            //myprofileViewController.profileImg.
                            if profile.userPicture != nil{
                                let url = URL(string: profile.userPicture!)//imageurl가져오기
                                let data = try? Data(contentsOf: url!)
                                if let imageData = data {
                                    let profileimage = UIImage(data: imageData)
                                    self.hamProfileimg.image = profileimage
                                    self.profileImg.image = profileimage
                                    self.profileImg.layer.borderColor = UIColor.gray.cgColor
                                    self.profileImg.layer.borderWidth = 0.1
                                    self.profileImg.layer.cornerRadius = self.profileImg.frame.height/2
                                    self.profileImg.clipsToBounds = true
                                    self.hamProfileimg.layer.borderColor = UIColor.gray.cgColor
                                    self.hamProfileimg.layer.borderWidth = 0.1
                                    self.hamProfileimg.layer.cornerRadius = self.hamProfileimg.frame.height/2
                                    self.hamProfileimg.clipsToBounds = true
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
        self.showIndicator()
        print(self.appDelegate.email!)
        let urlstr = self.appDelegate.email!
        print(urlstr)
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email!)/posts?current=\(self.current)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
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
                                            //print("Igotit")
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
    override func viewWillAppear(_ animated: Bool) {
        if self.appDelegate.change == true{
            self.appDelegate.change = false
            replyarr[(self.appDelegate.indexpath2!.row)] = self.appDelegate.rep!
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
        
        mycollView.delegate = self
        mycollView.dataSource = self
        mycollView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collCell")
        //self.mycollView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "callCell")
        //picturearr = getFeeds(inputArray: picturearr)
        imagearr = getImages(inputArray: imagearr)
        arr = getProfile(inputArray: arr)
        //nickNamearr = getFeeds(inputArray: nickNamearr)
       
        
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "feedCell")
        self.navigationItem.title = "마이 프로필"
        navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
        nickNamearr = getFeeds(inputArray: nickNamearr)
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
                Cell.profileimg.layer.borderColor = UIColor.gray.cgColor
                Cell.profileimg.layer.borderWidth = 0.1
                Cell.profileimg.layer.cornerRadius = Cell.profileimg.frame.height/2
                Cell.profileimg.clipsToBounds = true
            }
        }else{
            Cell.profileimg.image = deprofile
        }
        
        // b = b + pictureNum[indexPath.row]
        Cell.nicknameLbl.text = nickNamearr[indexPath.row]
        Cell.feedLbl.sizeToFit()
        Cell.feedLbl.text = contentarr[indexPath.row]
        Cell.locationLbl.text = locationarr[indexPath.row]
        Cell.timeagoLbl.text = timeAgoarr[indexPath.row]
        Cell.heartLbl.text = String(heartarr[indexPath.row])
        Cell.replyLbl.text = replyarr[indexPath.row]
        
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
        print("선택된 cell 번호")
        print(postNoarr[indexPath.row])
        self.appDelegate.indexpath = postNoarr[indexPath.row]
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

extension MyProfileViewController: UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("cell 갯수")
        print(feedImages2.count)
        return self.i2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! CollectionViewCell
        print("yougotig")
       /* if feedImages2[indexPath.row] == UIImage(named: "ic_blank"){
            //self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            imageView = UIImageView(image: blank)
            imageViews2[indexPath.row] = imageView!
        }else{*/
            print("gotit")
            imageView = UIImageView(image: feedImages2[indexPath.row])
            //imageView!.frame = CGRect(x:0, y: 0, width: 60, height: 60)
            cell.imageView.image = feedImages2[indexPath.row]
            imageViews2[indexPath.row] = imageView!
        //}
        if indexPath.row == self.i2 - 1 {
            count2 = count2 + 1
            if count2 == 2{
                print("ok")
                current2 = current2 + 5
                //self.tableView.reloadData()
              //  picturearr = getImages(inputArray: picturearr)
                imagearr = getImages(inputArray: imagearr)
                count2 = 0
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWithd = collectionView.frame.width / 3 - 1
        return CGSize(width: collectionViewCellWithd, height: collectionViewCellWithd)
    }
    
    //위아래 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //옆 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

