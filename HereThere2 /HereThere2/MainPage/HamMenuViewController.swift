//
//  HamMenuViewController.swift
//  HereThere2
//
//  Created by 우소연 on 30/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class HamMenuViewController: BaseViewController {
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
        main.backgroundColor =
            UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HERETHERE"
    
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: ColorPalette.swiftColor, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(menuBtnTapped))
    }
    
    @objc func menuBtnTapped() {
        if(ishidden == false){
            hamLeadingC.constant = 0
            hamTrailingC.constant = 410
            ishidden = true
            main.backgroundColor =
                UIColor.white
        }else{
            ishidden = false
            hamLeadingC.constant = 0
            hamTrailingC.constant = 158
            main.backgroundColor =
                UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }){ (animationComplete) in
            print("====")
        }
        
    }

}
