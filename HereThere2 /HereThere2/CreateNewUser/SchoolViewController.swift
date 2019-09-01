//
//  SchoolViewController.swift
//  HereThere2
//
//  Created by 우소연 on 28/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase
import FirebaseStorage

class SchoolViewController: BaseViewController {
    //let storage = Storage.storage()
    
    
    @IBOutlet weak var schoolTxt: UITextField!
    let schoolnotok : UIImage = UIImage(named:"ic_schoolnotok")!
    let schoolok : UIImage = UIImage(named:"ic_schoolok")!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var schooltxt: UITextField!
    @IBOutlet weak var schoolbtn: UIButton!{
        didSet{
            schoolbtn.setImage(schoolnotok, for: UIControl.State.normal)
        }
    }
    @IBAction func cameraBtn(_ sender: Any) {
        if(self.schoolbtn.currentImage == schoolnotok){
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
        }else{
            self.navigationController!.pushViewController(SchoolOkViewController(), animated: true)
        }
    }
    
    lazy var rightButton: UIBarButtonItem = { let button = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.navigationItem.rightBarButtonItem = self.rightButton

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        schooltxt.attributedPlaceholder = NSAttributedString(string: "학교 이름",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       
    }
    
    @objc private func buttonPressed(_ sender: Any) { if let button = sender as? UIBarButtonItem {
        switch button.tag {
        case 1: // Change the background color to blue.
            self.navigationController!.pushViewController(SNationViewController(), animated: true)
        default:
            break
        }
        }
    }
}
    
extension SchoolViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
        schoolbtn.setImage(schoolok, for: UIControl.State.normal)
    }
}

