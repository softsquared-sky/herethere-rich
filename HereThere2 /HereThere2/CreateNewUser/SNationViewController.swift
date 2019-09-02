//
//  SNationViewController.swift
//  HereThere2
//
//  Created by 우소연 on 28/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class SNationViewController: BaseViewController, UITableViewDataSource {
    lazy var rightButton: UIBarButtonItem = { let button = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    var empty = [Int](repeating: 0, count: 74)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let up : UIImage = UIImage(named:"ic_up")!
    let down : UIImage = UIImage(named:"ic_down")!
    let chk : UIImage = UIImage(named:"ic_click")!
    let unchk : UIImage = UIImage(named:"ic_unclick")!
    let nonpick : UIImage = UIImage(named:"ic_nonpick")!
    let picked : UIImage = UIImage(named:"ic_pick")!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
        }
    }
    var arr2 = [String]()
    
    
    @IBOutlet weak var pick: UIButton!{
        didSet{
           
            pick.setImage(nonpick, for: UIControl.State.normal)
            pick.isEnabled = false

        }
    }
    @IBAction func pickpressed(_ sender: Any) {
        
        MainDataManager().postnation(self)
        self.navigationController!.pushViewController(FinishViewController(), animated: true)
    }
    
    @IBOutlet weak var pickerbtn: UIButton!
    @IBOutlet weak var pickerdown: UIButton!
    @IBAction func pickerBtnC(_ sender: Any) {
        if(self.pickerdown.currentImage == down){
            pickerdown.setImage(up, for: UIControl.State.normal)
            tableView.isHidden = false
            var i = 0
            for index in 0..<empty.count{
                i = i + empty[index]
            }
            if(i == 0){
                pickerbtn.setTitle("", for: UIControl.State.normal)
            }else{
                pickerbtn.setTitle(pickerbtn.currentTitle, for: UIControl.State.normal)
            }
            
        } else if(self.pickerdown.currentImage == up){
            pickerdown.setImage(down, for: UIControl.State.normal)
            tableView.isHidden = true
            var i = 0
            for index in 0..<empty.count{
                i = i + empty[index]
            }
            if(i == 0){
                pickerbtn.setTitle("관심지역 선택하기", for: UIControl.State.normal)
            }else{
                pickerbtn.setTitle(pickerbtn.currentTitle, for: UIControl.State.normal)
                
            }
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "NationTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "nationCell")
        
        self.navigationItem.rightBarButtonItem = self.rightButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        arr2 = getNation(inputArray: arr2)
        for i in 0..<arr2.count{
            print(arr2[i])
            print("======")
        }
    }
    
//건너뛰기
    @objc private func buttonPressed(_ sender: Any) { if let button = sender as? UIBarButtonItem {
        switch button.tag {
        case 1: // Change the background color to blue.
            self.navigationController!.pushViewController(HamMenuViewController(), animated: true)
        default:
            break
        }
        }
    }

}

extension SNationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nationCell = tableView.dequeueReusableCell(withIdentifier: "nationCell", for: indexPath) as! NationTableViewCell
        nationCell.nationLabel.text = arr2[indexPath.row]
        nationCell.nationLabel.sizeToFit()
        if(empty[indexPath.row] == 0){
            nationCell.chckbtn.setImage(unchk, for: UIControl.State.normal)
        }else if(empty[indexPath.row] == 1){
            nationCell.chckbtn.setImage(chk, for: UIControl.State.normal)
        }
        nationCell.chckbtn.addTarget(self, action:  #selector(connected(sender:)), for: .touchUpInside)
        nationCell.chckbtn.tag = indexPath.row
        return nationCell
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        if(empty[buttonTag] == 1){
            sender.setImage(unchk, for: UIControl.State.normal)
            let newString = pickerbtn.currentTitle!.replacingOccurrences(of: " " + arr2[buttonTag], with: "")
            pickerbtn.setTitle(newString, for: .normal)
            empty[buttonTag] = 0
        }else if(empty[buttonTag] == 0){
            sender.setImage(chk, for: UIControl.State.normal)
            empty[buttonTag] = 1
            let first = pickerbtn.currentTitle
            let second = first! + " " + arr2[buttonTag]
            pickerbtn.setTitle(second, for: .normal)
        }
        var i = 0
        for index in 0..<empty.count{
            i = i + empty[index]
        }
        if(i == 0){
            pick.setImage(nonpick, for: UIControl.State.normal)
            pick.isEnabled = false
        }else{
            pick.setImage(picked, for: UIControl.State.normal)
            pick.isEnabled = true
            
        }
    }
}
