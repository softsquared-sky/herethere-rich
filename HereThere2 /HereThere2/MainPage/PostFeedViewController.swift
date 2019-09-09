//
//  PostFeedViewController.swift
//  HereThere2
//
//  Created by 우소연 on 08/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//
import UIKit
import AlamofireObjectMapper
import Alamofire

class PostFeedViewController: BaseViewController, UITableViewDataSource, UITextFieldDelegate {
    lazy var rightButton: UIBarButtonItem = { let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    var count = 0
    var mar = 186
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainview: UIView!
   
    var scrollView2: UIScrollView!
    let picker = UIImagePickerController()
    @IBOutlet weak var addPicture: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var arr2 = [String]()
    var empty = [Int](repeating: 0, count: 74)
     var check: Int!
    let up : UIImage = UIImage(named:"ic_up")!
    let down : UIImage = UIImage(named:"ic_down")!
    let chk : UIImage = UIImage(named:"ic_click")!
    let unchk : UIImage = UIImage(named:"ic_unclick")!
    let nonpick : UIImage = UIImage(named:"ic_nonpick")!
    let picked : UIImage = UIImage(named:"ic_pick")!
    
    
    @IBAction func addBtn(_ sender: Any) {
            let alert = UIAlertController(title: "학교 인증 이미지 등록", message: "사진 앨범 / 카메라", preferredStyle: .actionSheet)
            let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
            }
            let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
                self.openCamera()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(library)
            alert.addAction(camera)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        //else
    }
    
    
    
    
    
    @IBOutlet weak var contentTxtField: UITextField!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
        }
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
        self.showIndicator()
        let url = URL(string: "http://52.79.198.51/location")!
        Alamofire.request(url, method: .get).validate().responseObject(completionHandler: { (response: DataResponse<NationResponse>) in
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
                }
                self.dismissIndicator()
                print(response)
                
            case .failure:
                self.dismissIndicator()
                print(response)
                self.presentAlert(title: "", message: "서버와의 연결이 원활하지 않습니다.")
            }
        })
        return arr2
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -90 // Move view 150 points upward
        
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        picker.delegate = self
        contentTxtField.delegate = self
        let nibName = UINib(nibName: "NationTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "nationCell")
        pickerbtn.layer.borderColor = UIColor.black.cgColor
        pickerbtn.layer.borderWidth = 1
        pickerbtn.layer.cornerRadius = 10
        addPicture.layer.borderColor = UIColor.black.cgColor
        addPicture.layer.borderWidth = 0.5
        addPicture.layer.cornerRadius = 10
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.isNavigationBarHidden = false
        self.navigationController!.navigationBar.tintColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = self.rightButton
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_backbtn")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_backbtn")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "게시글 작성"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        
        contentTxtField.attributedPlaceholder = NSAttributedString(string: "게시글을 써주세요",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        arr2 = getNation(inputArray: arr2)
        
    }
    @objc private func buttonPressed(_ sender: Any) { if let button = sender as? UIBarButtonItem {
        switch button.tag {
        case 1: // Change the background color to blue.
             RegFeedDataManager().uploadFeed(self)
        default:
            break
        }
        }
    }
    
}
extension PostFeedViewController: UITableViewDelegate{
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
        
        //버튼이 눌릴경우
        if(empty[buttonTag] == 1){
            sender.setImage(unchk, for: UIControl.State.normal)
            pickerbtn.setTitle("", for: .normal)
            empty[buttonTag] = 0
        }else if(empty[buttonTag] == 0){
            if(pickerbtn.currentTitle != ""){
                presentAlert(title: "", message: "국가는 한 곳만 선택할 수 있습니다.")
                return
            }
            sender.setImage(chk, for: UIControl.State.normal)
            empty[buttonTag] = 1
            pickerbtn.setTitle(arr2[buttonTag], for: UIControl.State.normal)
        }
        var i = 0
        for index in 0..<empty.count{
            i = i + empty[index]
        }
    }
}

extension PostFeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
            //schoolbtn.setImage(schoolok, for: UIControl.State.normal)
        }
        else{
            print("Camera not available")
            self.presentAlert(title: "", message: "카메라 접근 오류가 발생했습니다.")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         let imageView = UIImageView()
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            print("Igotit")
            //imageView.frame = CGRect(x: mar, y: 16, width: 160, height: 121)
            imageView.image = image
            let imageURL = info[UIImagePickerController.InfoKey.imageURL]
            print(imageURL!)
            dismiss(animated: true, completion: nil)
        }
        scrollView.contentSize.width =
            self.view.frame.width * CGFloat(mar + 300)
        print("OKKKKKKK")
        print(mar)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        scrollView.bringSubviewToFront(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 121).isActive = true
        imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: CGFloat(mar)).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        mar = mar + 170
    }
}
