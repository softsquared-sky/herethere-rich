//
//  HomeViewController.swift
//  HereThere2
//
//  Created by 우소연 on 31/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class HomeViewController: BaseViewController, UITableViewDataSource {
    var nickNamearr = [String]()
    var contentarr = [String]()
    var locationarr = [String]()
    var timeAgoarr = [String]()
    var heartarr = [Int]()
    var replyarr = [String]()
   
    @IBOutlet weak var fakeTrailingC: NSLayoutConstraint!{
        didSet{
            fakeTrailingC.constant = 0
        }
    }
    @IBOutlet weak var fakeLeadingC: NSLayoutConstraint!{
        didSet{
            fakeLeadingC.constant = 410
            
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
    @IBOutlet weak var main: UIView!
    @IBOutlet weak var hamTrailingC: NSLayoutConstraint!{
        didSet{
            hamTrailingC.constant = 430
        }
    }
    @IBOutlet weak var hamLeadingC: NSLayoutConstraint!{
        didSet{
            hamLeadingC.constant = 0
        }
    }
    let arr = ["대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다. 언론·출판은 타인의 명예나 권리 또는 공중도덕이나 사회윤리를 침해하여서는 아니된다. 언론·출판이 타인의 명예나 권리를 침해한 때에는 피해자는 이에 대한 피해의 배상을 청구할 수 있다..", "가나다라마바사아차자아", "아아아아아우아아아아아아아"]
    @IBAction func logoutbtn(_ sender: Any) {
        self.navigationController!.pushViewController(LogoutViewController(), animated: true)
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getFeeds(inputArray:Array<String>) -> Array<String>{
    //func getFeeds() {
        Alamofire
            //.request("\(self.appDelegate.baseUrl)/tutorials", method: .get)
            .request("\(self.appDelegate.baseUrl)/posts?current=0", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetFeedResponse>) in
                switch response.result {
                case .success(let getfeedResponse):
                    if getfeedResponse.code == 102 {
                        //print(getfeedResponse.message)
                        let feedResponse = response.result.value
                        
                        print(feedResponse!)
                        if let feeds = feedResponse?.feeds{
                            for feed in feeds {
                                //self.nickNamearr.append(feed?.nickName!)
                                self.nickNamearr.append(feed.nickName!)
                                self.contentarr.append(feed.postContents!)
                                self.locationarr.append(feed.postLocation!)
                                self.timeAgoarr.append(feed.timeAgo!)
                                self.heartarr.append(feed.heart!)
                                self.replyarr.append(feed.comment!)
                                
                                print("=====================")
                                print(feed.nickName!)
                                print("=====================")
                                //print(getfeedResponse.message!)
                            }
                            self.tableView.reloadData()
                        }
                        // GetFeedResponse.messa
                        //print(response)
                    } else {
                        //loginViewController.titleLabel.text = "튜토리얼 정보를 불러오는데 실패하였습니다."
                    }
                    
                case .failure:
                    break
                    //loginViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
                print(response)
            })
         return nickNamearr
    }
   

    /*
    func getFeed(){
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
    }*/
    let imgIcon = UIImage(named: "ic_hammenu")?.withRenderingMode(.alwaysOriginal)
    
    @IBAction func dismissbtn(_ sender: Any) {
        hamLeadingC.constant = 0
        hamTrailingC.constant = 410
        ishidden = true
        fakeLeadingC.constant = 410
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print("=====================")
    }
    
    @objc func menuBtnTapped() {
        if(ishidden == false){//사라지기
            hamLeadingC.constant = 0
            hamTrailingC.constant = 410
            ishidden = true
            fakeLeadingC.constant = 410
            fakeTrailingC.constant = 0
            print("show")
        }else{
            ishidden = false
            hamLeadingC.constant = 0
            hamTrailingC.constant = 158
            //tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            fakeLeadingC.constant = 0
            fakeTrailingC.constant = 158
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
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nickNamearr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let url = URL(string: "http://naver.com/lemon.jpg")//imageurl가져오기
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let profileimage = UIImage(data: imageData)
            Cell.profileimg.image = profileimage
        }
        Cell.nicknameLbl.text = nickNamearr[indexPath.row]
        Cell.feedLbl.sizeToFit()
        Cell.feedLbl.text = contentarr[indexPath.row]
        Cell.locationLbl.text = locationarr[indexPath.row]
        Cell.timeagoLbl.text = timeAgoarr[indexPath.row]
        Cell.heartBtn.setTitle(String(heartarr[indexPath.row]), for: .normal)
        Cell.replyBtn.setTitle(replyarr[indexPath.row], for: .normal)
         
        
        return Cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
