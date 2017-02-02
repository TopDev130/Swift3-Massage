//
//  CustomSpecialityView.swift
//  Massage
//
//  Created by Panda2 on 11/8/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Koloda

class CustomSpecialityView: KolodaView {
    
    @IBOutlet weak var treatmentImage: UIImageView!
    @IBOutlet weak var treatmentName: UILabel!
    @IBOutlet weak var treatmentDescription: UILabel!
    @IBOutlet weak var treatmentDetailView: UIView!
    
    private let defaultBackgroundCardsTopMargin: CGFloat = 0.7
    private let defaultBackgroundCardsLeftMargin: CGFloat = -0.7
    private let defaultBackgroundCardsScalePercent: CGFloat = 0.7
    
    override func frameForCard(at index: Int) -> CGRect {
        
        let bottomOffset:CGFloat = 100
        let topOffset = defaultBackgroundCardsTopMargin * CGFloat(self.countOfVisibleCards - 1)
        let xOffset = defaultBackgroundCardsLeftMargin * CGFloat(index)
        let scalePercent = defaultBackgroundCardsScalePercent
        let width = self.frame.width * pow(scalePercent, CGFloat(index))
        let height = (self.frame.height - bottomOffset - topOffset) * pow(scalePercent, CGFloat(index))
        let multiplier: CGFloat = index > 0 ? 1.0 : 0.0
        let previousCardFrame = index > 0 ? frameForCard(at: max(index - 1, 0)) : CGRect.zero
        let yOffset = (previousCardFrame.height - height + previousCardFrame.origin.y + defaultBackgroundCardsTopMargin) * multiplier
        let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)

        return frame

    }
}
