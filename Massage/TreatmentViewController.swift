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
import KVNProgress
import Localize_Swift

private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 3
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.6

class TreatmentViewController: UIViewController {
    
    @IBOutlet weak var treatmentView: CustomSpecialityView!
    @IBOutlet weak var SelectTreatmentLabel: UILabel!
    @IBOutlet weak var SelectDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SelectTreatmentLabel.text = "SelectTreatment".localized()
        SelectDescriptionLabel.text = "SelectTreatmentDescription".localized()
        
        treatmentView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        treatmentView.countOfVisibleCards = kolodaCountOfVisibleCards
        treatmentView.delegate = self
        treatmentView.dataSource = self
//        treatmentView.animator = BackgroundKolodaAnimator(koloda: treatmentView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        if SpecialityManager.sharedInstance.currentSpecialites.value.count == 0 {
//            KVNProgress.show(withStatus: "", on: self.view)
            SpecialityManager.sharedInstance.loadSpecialities(completionHandler: { [weak self] errorOpt in
                Loader.hide()
                if let error = errorOpt {
                    ErrorDisplay.displayAPIError(error, from: self)
                    print("error ==", error)
                } else {
                    self?.treatmentView.reloadData()
                }
                })
        } else {
            Loader.hide()
        }
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
extension TreatmentViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return SpecialityManager.sharedInstance.currentSpecialites.value.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let treatmentView = Bundle.main.loadNibNamed("CustomSpecialityView", owner: self, options: nil)?.first as! CustomSpecialityView
        
        let treatment = SpecialityManager.sharedInstance.currentSpecialites.value[Int(index)]
        
        treatmentView.treatmentName.text = treatment.name.localized()
        treatmentView.treatmentDescription.text = treatment.descriptionStr.localized()
        treatmentView.treatmentImage.image = UIImage(data: treatment.imgData!)
        
        treatmentView.treatmentImage.layer.masksToBounds = true
        let rectShape = CAShapeLayer()
        rectShape.bounds = treatmentView.treatmentImage.frame
        rectShape.position = treatmentView.treatmentImage.center
        rectShape.path = UIBezierPath(roundedRect: treatmentView.treatmentImage.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        treatmentView.treatmentImage.layer.mask = rectShape
        
        treatmentView.treatmentDetailView.layer.masksToBounds = true
        let rectShape1 = CAShapeLayer()
        rectShape1.bounds = treatmentView.treatmentDetailView.frame
        rectShape1.position = treatmentView.treatmentDetailView.center
        rectShape1.path = UIBezierPath(roundedRect: treatmentView.treatmentDetailView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        treatmentView.treatmentDetailView.layer.mask = rectShape1
        
        return treatmentView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
//        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
