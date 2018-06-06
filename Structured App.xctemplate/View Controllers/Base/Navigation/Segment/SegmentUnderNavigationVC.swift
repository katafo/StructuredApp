//
//  SegmentUnderNavigationVC.swift
//  Vincere
//
//  Created by Phong Cao on 11/16/17.
//  Copyright © 2017 Trai Nguyen. All rights reserved.
//

import UIKit

// Segment under navigation bar

class SegmentUnderNavigationVC: SegmentNavigationVC{
    
    var selectedColor: UIColor = .tomato
    
    override func initSegmentControl(titles: [String]) {
        
        segmentControl = VincereSegmentControl(items: titles)
        segmentControl.frame = CGRect(x: 0, y: headerView.frame.height, width: ScreenSize.SCREEN_WIDTH, height: 40)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedColor = self.selectedColor
        segmentControl.normalColor = UIColor(r: 50, g: 50, b: 50, alpha: 0.6)

        view.addSubview(segmentControl)
        contentTopConstraint.constant += segmentControl.frame.height
        
        if #available(iOS 11.0, *) {
            
        }else{
            
            // Using XIB on iOS 10 or later , safe area layout not working so we need add more 20px to topConstraint.
            contentTopConstraint.constant += 20
            edgesForExtendedLayout = []

        }
        
    }

    override func setupLeftBarButton() {
     
        let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_left_arrow"), style: .plain, target: self, action: #selector(self.tappedLeftButtonItem))
        navItem.leftBarButtonItem = backButtonItem

    }
    
    //MARK: - ACTION
    
    override func tappedLeftButtonItem() {
        navigationController?.popViewController(animated: true)
    }
    
}
