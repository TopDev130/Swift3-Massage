//
//  WorkerCollectionCell.swift
//  b2c-ios
//
//  Created by Giles Williams on 15/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import UIKit
import Localize_Swift

private let IMAGE_SIZE: CGFloat = 60

class WorkerCollectionCell : UICollectionViewCell {
  @IBOutlet var borderViews: [UIView]!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var ratingContainerView: UIView!
  @IBOutlet var buttonLabel: UILabel!
  
  func setupWithWorker(_ worker: Worker) {
    self.layer.borderColor = Color.divider.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 6
    
    self.buttonLabel.textColor = Color.selected
    self.buttonLabel.text = "SpecialityCellBookButtonLabel".localized()
    
    self.imageView.layer.borderColor = Color.divider.cgColor
    self.imageView.layer.borderWidth = 1
    self.imageView.layer.cornerRadius = IMAGE_SIZE / 2
    
    self.ratingContainerView.layer.cornerRadius = 3
    
    for borderView in self.borderViews {
      borderView.backgroundColor = Color.divider
    }
    
    self.nameLabel.text = worker.name
    self.ratingLabel.text = String(format: "%.1f", worker.rating)
  }
}
