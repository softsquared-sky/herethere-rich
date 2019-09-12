//
//  MyCollectionViewController.swift
//  HereThere2
//
//  Created by 우소연 on 10/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

private let reuseIdentifier = "callCell"

class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var mycollView: UICollectionView!
    var picturearr = [String]()
     var current = 0
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getFeeds(inputArray:Array<String>) -> Array<String>{
       // self.showIndicator()
        Alamofire.request("\(self.appDelegate.baseUrl)/user/\(self.appDelegate.email)/posts/pictures?current=\(self.current)", method: .get, headers: ["x-access-token": self.appDelegate.myjwt!])
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<GetImagesDataResponse>) in
                switch response.result {
                case .success(let getimageResponse):
                    if getimageResponse.code == 102 {
                        let imageResponse = response.result.value
                        if let images = imageResponse?.images{
                            for image in images {
                                //self.nickNamearr.append(feed?.nickName!)
                                self.picturearr.append(image.postPicture!)
                                //print("none")
                            }
                            print("777777777")
                            print(self.picturearr)
                        }
                        self.collectionView.reloadData()
                    }
                    else if getimageResponse.code == 106{
                        self.presentAlert(title: "알림", message: "게시물이 없습니다.")
                    }
                    //self.dismissIndicator()
                case .failure:
                   // self.dismissIndicator()
                    break
                    //loginViewController.titleLabel.text = "서버와의 연결이 원활하지 않습니다."
                }
                print(response)
            })
        return picturearr
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        picturearr = getFeeds(inputArray: picturearr)
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return picturearr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "callCell", for: indexPath) as! CollectionViewCell
        let url = URL(string: picturearr[indexPath.row])//imageurl가져오기
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let feedimage = UIImage(data: imageData)
            cell.imageView.image = feedimage
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWithd = collectionView.frame.width / 3 - 1
        return CGSize(width: collectionViewCellWithd, height: collectionViewCellWithd)
    }
    
    //위아래 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //옆 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    

