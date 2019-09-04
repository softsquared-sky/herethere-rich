//
//  profileViewController.swift
//  HereThere2
//
//  Created by 우소연 on 03/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class profileViewController: BaseViewController{//, UITableViewDataSource {
    
    /*
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
            hamTrailingC.constant = 410
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
    let imgIcon = UIImage(named: "ic_hammenu")?.withRenderingMode(.alwaysOriginal)
    
    @IBAction func dismissbtn(_ sender: Any) {
        hamLeadingC.constant = 0
        hamTrailingC.constant = 410
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
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "profileTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "profileCell")
        self.navigationItem.title = "마이 프로필"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
    }
    //햄버거 메뉴 버튼 클릭
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
        
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
/*
extension profileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        Cell.feedLbl.text = arr[indexPath.row]
        Cell.feedLbl.sizeToFit()
        Cell.locationLbl.text = "spain"
        Cell.nicknameLbl.text = "lemon"
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}*/
