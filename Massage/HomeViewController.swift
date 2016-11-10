//
//  HomeViewController.swift
//  Massage
//
//  Created by Panda2 on 11/10/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var TitleView: UIView!
    @IBOutlet weak var nearByLabel: UILabel!
    @IBOutlet weak var dateDropButton: UIButton!
    @IBOutlet weak var seeAllButton: UIButton!
    
    @IBOutlet weak var therapistScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        TitleView.layer.borderWidth = 1
//        TitleView.layer.borderColor = Color.canvasBG.cgColor
        nearByLabel.text = "nearByLabel".localized()
        dateDropButton.setTitle("nextDate7days".localized(), for: .normal)
        seeAllButton.setTitle("seeAll".localized(), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutSubviews()
        
        let customTherapistView: WorkerCollectionCell = Bundle.main.loadNibNamed("WorkerCollectionCell", owner: nil, options: nil)![0] as! WorkerCollectionCell
        var stepWidth: CGFloat = 0;
        
        self.therapistScrollView.contentSize = CGSize(width: customTherapistView.frame.size.width * 3, height: customTherapistView.frame.size.height)
        
        for therapist in WorkerManager.sharedInstance.currentWorkers.value {
            customTherapistView.setupWithWorker(therapist)
            customTherapistView.frame = CGRect(x: stepWidth, y: 0, width: customTherapistView.frame.width, height: customTherapistView.frame.height)
            
            stepWidth += customTherapistView.frame.width + 20
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
