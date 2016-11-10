//
//  SpecialityCollectionCell.swift
//  b2c-ios
//
//  Created by Giles Williams on 15/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import UIKit
import Localize_Swift

class SpecialityCollectionCell : UICollectionViewCell {
  @IBOutlet var borderViews: [UIView]!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var buttonLabel: UILabel!
  
  func setupWithSpeciality(_ speciality: Speciality) {
    self.layer.borderColor = Color.divider.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 6
    
    self.buttonLabel.textColor = Color.selected
    self.buttonLabel.text = "SpecialityCellBookButtonLabel".localized()
    
    for borderView in self.borderViews {
      borderView.backgroundColor = Color.divider
    }
    
    
    self.nameLabel.text = speciality.name
    self.descriptionLabel.text = speciality.tagLine
  }
}
