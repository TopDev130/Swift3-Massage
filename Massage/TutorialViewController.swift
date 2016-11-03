//
//  TutorialViewController.swift
//  Massage
//
//  Created by HarukiMori on 11/3/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        let next = UISwipeGestureRecognizer(target: self, action: #selector(TutorialViewController.handleSwipes(sender:)))
        
        next.direction = .left
        next.delegate = self
        view.addGestureRecognizer(next)
        
        self.pageControl.transform = CGAffineTransform(scaleX: 1, y: 1.2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutSubviews()
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 4, height: self.view.frame.size.height)
        
        let tutorialStoryboard = UIStoryboard.init(name: "Tutorial", bundle: nil)
        
        var pageIndex = 0
        
        while pageIndex < 4 {
            let pageStoryboardName = "TutorialPage\(pageIndex+1)"
            
            let pageViewController = tutorialStoryboard.instantiateViewController(withIdentifier: pageStoryboardName)
            
            pageViewController.view.frame = CGRect(x: self.view.frame.size.width * CGFloat(pageIndex), y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.addChildViewController(pageViewController)
            pageViewController.didMove(toParentViewController: self)
            self.scrollView.addSubview(pageViewController.view)
            
            pageIndex += 1
            
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            if self.pageControl.currentPage == 2 {
                doSkipAction()
            }
        }
    }
    
    func doSkipAction() {
        print("Skip function")
    }
    
    @IBAction func changePage(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations: {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width * CGFloat(whichPage), y: 0)
        })
    }
    
    @IBAction func onSkipButtonClicked(_ sender: AnyObject) {
        doSkipAction()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x) / Int(self.scrollView.frame.size.width)
        
    }

}
