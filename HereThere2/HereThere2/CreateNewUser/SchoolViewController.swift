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

    @IBOutlet weak var unvalidLabel: UILabel!
    var schoolname = ""
    @IBOutlet weak var schoolTxt: UITextField!
    let schoolnotok : UIImage = UIImage(named:"ic_schoolnotok")!
    let schoolok : UIImage = UIImage(named:"ic_schoolok")!
    let picker = UIImagePickerController()
    //let imageURL : String?
    
    @IBOutlet weak var imageView: UIImageView!
    
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
            MainDataManager().getschool(self)
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
        schoolTxt.delegate = self
        self.navigationItem.rightBarButtonItem = self.rightButton

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        let testColor = UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = testColor
        view.backgroundColor = testColor
        schoolTxt.attributedPlaceholder = NSAttributedString(string: "학교 이름을 입력해주세요.",
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
extension SchoolViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = self.schoolTxt.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            schoolname = updatedText
            print(updatedText)
        }
        if (imageView.image != nil) && (schoolname != "") {
            schoolbtn.setImage(schoolok, for: UIControl.State.normal)
            unvalidLabel.isHidden = true
        }else if schoolname == "" {
            unvalidLabel.isHidden = false
        }
        return true
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
           // print(info)
            let imageURL = info[UIImagePickerController.InfoKey.imageURL]
            print(imageURL!)
            //upload(imageURL! as! NSURL)
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    /*
    func upload(_ imageURL: NSURL){
        let storageRef = Storage.storage().reference()
        let profilesRef = storageRef.child("profile.jpg")
        let profileImagesRef = storageRef.child("images/profiles.jpg")
        // While the file names are the same, the references point to different files
        profilesRef.name == profileImagesRef.name;            // true
        profilesRef.fullPath == profileImagesRef.fullPath;    // false
        
        //let filepath = imageURL
        //let imagedata = imageView.image!.jpegData(compressionQuality: 0.75)
        let localFile = URL(imageURL)
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = profilesRef.putFile(from: localFile as URL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print(error)
                    // Uh-oh, an error occurred!
                    return
                }
                print(downloadURL)
            }
        }
        schoolbtn.setImage(schoolok, for: UIControl.State.normal)
    }*/
}
/*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
}*/




