//
//  newUserViewController.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import UIKit

class newUserViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    
    var index : Int = 0;
    var indexMin = 0;
    var indexMax = 2;
    
    // restoreIdentifier
    var identifiers: NSArray = ["emailVC", "pwVC", "personalVC"]
    
    // The custom UIPageControl
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.delegate = self
        self.dataSource = self
        
        index = 0
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as! [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        // PageControl 세팅
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.identifiers.count
        self.pageControl.currentPage = 0
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK:- UIPageViewControllerDataSource Methods
    // 이전 화면 그리기
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let identifier = viewController.restorationIdentifier
        var index = self.identifiers.index(of: identifier)
        
        NSLog("newUserViewController viewControllerBefore index : %d", index)
        
        if index == 0
        {
            return nil
        }
        
        //decrement the index to get the viewController before the current one
        self.index = index - 1
        
        return getViewControllerAtIndex (index: self.index)
    }
    
    // 다음 화면 그리기
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        
        
        let identifier = viewController.restorationIdentifier
        var index = self.identifiers.index(of: identifier)
        
        NSLog("newUserViewController viewControllerAfter index : %d", index)
        
        if (index == self.identifiers.count-1)
        {
            return nil
        }
        
       
         self.index = index + 1
        
        return getViewControllerAtIndex (index: self.index)
    }
    
    // 현재 페이지 구하기
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let currentPage : Int = self.identifiers.index(of: pendingViewControllers[0].restorationIdentifier)
        NSLog("newUserViewController willTransitionTo index = %d", currentPage)
        self.pageControl.currentPage = currentPage
    }
    
    // 인디케이터에 반영할 항목 갯수 반환
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return self.identifiers.count
    }
    
    // 페이지 인디케이터에 반영할 아이템 인덱스
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
    
    
    
    // MARK:- Other Methods
    func getViewControllerAtIndex(index: NSInteger) -> UIViewController?
    {
        NSLog("newUserViewController getViewControllerAtIndex index : %d", index)
        
        if index == 0
        {
            let storyboard = UIStoryboard(name: "newUser", bundle: nil);
            let emailVC = storyboard.instantiateViewController(withIdentifier: "emailVC")
            return emailVC
        }
        else if index == 1
        {
            
            let storyboard = UIStoryboard(name: "newUser", bundle: nil);
            let pwVC = storyboard.instantiateViewController(withIdentifier: "pwVC")
            return pwVC
        }
        else if index == 2
        {
            let storyboard = UIStoryboard(name: "newUser", bundle: nil);
            let personalVC = storyboard.instantiateViewController(withIdentifier: "personalVC") 
            return personalVC
        }
        else
        {
            return nil
        }
    }
}

    

