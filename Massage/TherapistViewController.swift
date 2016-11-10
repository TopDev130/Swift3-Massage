//
//  TherapistViewController.swift
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
private let kolodaCountOfVisibleCards = 3
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class TherapistViewController: UIViewController {
    
    @IBOutlet weak var therapistView: CustomTherapistView!
    @IBOutlet weak var SelectTherapistLabel: UILabel!
    @IBOutlet weak var SelectTherapistDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SelectTherapistLabel.text = "SelectTherapist".localized()
        SelectTherapistDescriptionLabel.text = "SelectTherapistDescription".localized()
        
        therapistView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        therapistView.countOfVisibleCards = kolodaCountOfVisibleCards
        therapistView.delegate = self
        therapistView.dataSource = self
        therapistView.animator = BackgroundKolodaAnimator(koloda: therapistView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        if WorkerManager.sharedInstance.currentWorkers.value.count == 0 {
            WorkerManager.sharedInstance.loadWorkers(limitCnt: 3, completionHandler: { [weak self] errorOpt in
                Loader.hide()
                if let error = errorOpt {
                    ErrorDisplay.displayAPIError(error, from: self)
                    print("error ==", error)
                } else {
                    self?.therapistView.reloadData()
                }
                })
        } else {
            Loader.hide()
        }
        if (CitiesManager.sharedInstance.currentCities.value.count == 0) {
            CitiesManager.sharedInstance.loadCities(completionHandler: { result in
            })
        }
    }
    
}

//MARK: KolodaViewDelegate
extension TherapistViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        therapistView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //        UIApplication.shared.open(URL(string: "http://yalantis.com/")!, options: nil, completionHandler: { })
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    //    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
    //        return [.right]
    //    }
    
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
extension TherapistViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return WorkerManager.sharedInstance.currentWorkers.value.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let TherapistView = Bundle.main.loadNibNamed("CustomTherapistView", owner: self, options: nil)?.first as! CustomTherapistView
        let Therapists = WorkerManager.sharedInstance.currentWorkers.value[Int(index)]
        
        TherapistView.profileImageView.layer.cornerRadius = 36
        TherapistView.profileImageView.layer.borderWidth = 1
        TherapistView.profileImageView.layer.masksToBounds = false
        TherapistView.profileImageView.layer.borderColor = Color.canvasBG.cgColor
        TherapistView.profileImageView.clipsToBounds = true
        TherapistView.profileImageView.image = UIImage(named: "959.png")
        TherapistView.nameLabel.text = Therapists.name.localized()
        TherapistView.descriptionLabel.text = Therapists.bio.localized()
        
        let ratingStr = "\(Therapists.rating)"
        TherapistView.starLabel.text = ratingStr
        
        return TherapistView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
        //        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
