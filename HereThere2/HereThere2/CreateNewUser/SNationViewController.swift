//
//  SNationViewController.swift
//  HereThere2
//
//  Created by 우소연 on 28/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class SNationViewController: BaseViewController, UITableViewDataSource {
    lazy var rightButton: UIBarButtonItem = { let button = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    var empty = [Int](repeating: 0, count: 74)
    
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
    
    let arr = ["가나", "가봉", "과테말라", "그리스", "남아프리카 공화국", "네덜란드", "네팔", "노르웨이", "뉴질랜드", "대한민국", "덴마크", "독일", "러시아", "루마니아", "룩셈부르크", "말레이시아", "멕시코", "모나코", "모로코" ,"몽골", "미국", "미얀마", "바티칸 시국", "베네수엘라", "베트남", "벨기에", "볼리비아", "부탄", "브라질", "브루나이", "사우디아라비아", "수단", "스웨덴", "스위스", "스페인", "싱가포르", "아랍에미리트", "아르헨티나", "아이슬란드" ,"에콰도르" ,"영국" ,"오스트레일리아" ,"오스트리아" ,"우루과이" ,"우즈베키스탄" ,"우크라이나" ,"이라크" ,"이란" ,"이스라엘" ,"이집트" ,"이탈리아" ,"인도" ,"인도네시아" ,"일본" ,"중화인민공화국" ,"체코" ,"칠레" ,"카자흐스탄" ,"캄보디아" ,"캐나다" ,"콜롬비아" ,"쿠바" ,"크로아티아" ,"태국" ,"터키" ,"파라과이" ,"파키스탄" ,"페루" ,"포르투갈" ,"폴란드" ,"프랑스" ,"핀란드" ,"필리핀" ,"헝가리"]
 
    @IBOutlet weak var pick: UIButton!{
        didSet{
            pick.setImage(nonpick, for: UIControl.State.normal)
            pick.isEnabled = false

        }
    }
    @IBAction func pickpressed(_ sender: Any) {
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
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nationCell = tableView.dequeueReusableCell(withIdentifier: "nationCell", for: indexPath) as! NationTableViewCell
        nationCell.nationLabel.text = arr[indexPath.row]
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
            let newString = pickerbtn.currentTitle!.replacingOccurrences(of: " " + arr[buttonTag], with: "")
            pickerbtn.setTitle(newString, for: .normal)
            empty[buttonTag] = 0
        }else if(empty[buttonTag] == 0){
            sender.setImage(chk, for: UIControl.State.normal)
            empty[buttonTag] = 1
            let first = pickerbtn.currentTitle
            let second = first! + " " + arr[buttonTag]
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
