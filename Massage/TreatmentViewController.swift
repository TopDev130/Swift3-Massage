//
//  TreatmentViewController.swift
//  Massage
//
//  Created by Panda2 on 11/4/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Koloda
import pop

private let numberOfCards: Int = 9
private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class TreatmentViewController: UIViewController {
    
    @IBOutlet weak var treatmentView: CustomKolodaView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        treatmentView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        treatmentView.countOfVisibleCards = kolodaCountOfVisibleCards
        treatmentView.delegate = self
        treatmentView.dataSource = self
        treatmentView.animator = BackgroundKolodaAnimator(koloda: treatmentView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal

    }
    
}

//MARK: KolodaViewDelegate
extension TreatmentViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        treatmentView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.open(URL(string: "http://yalantis.com/")!, options: nil, completionHandler: { })
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

//MARK: KolodaViewDataSource
extension TreatmentViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return numberOfCards
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        return UIImageView(image: UIImage(named: "card\(index + 1).png"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
//        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
