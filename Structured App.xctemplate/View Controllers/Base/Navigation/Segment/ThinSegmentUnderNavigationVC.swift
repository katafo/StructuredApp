//
//  File.swift
//  Vincere
//
//  Created by Kiet Truong on 11/23/17.
//  Copyright © 2017 Trai Nguyen. All rights reserved.
//

import UIKit

// Info view + thin segment(no text) under navigation bar

class ThinSegmentUnderNavigationVC: SegmentNavigationVC {
    
    var infoView = UIView()
    var lblTitle: UILabel = UILabel()
    var lblNumber: UILabel = UILabel()
    
    override func initSegmentControl(titles: [String]) {

        self.infoView.frame = CGRect(x: 0, y: navBar.frame.origin.y + navBar.frame.height, width: ScreenSize.SCREEN_WIDTH, height: 60)
        self.infoView.backgroundColor = UIColor(r: 244, g: 244, b: 244, alpha: 1)
        self.view.addSubview(infoView)
        
        self.lblTitle.text = "Title"
        self.lblTitle.font = UIFont.openSansSemiBold()
        self.lblTitle.textColor = UIColor.black
        self.lblTitle.textAlignment = .left
        self.lblTitle.numberOfLines = 1
        infoView.addSubview(self.lblTitle)
        self.lblTitle.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.lblTitle.snp.makeConstraints { (make) in
            make.left.equalTo(infoView).offset(17)
            make.top.equalTo(infoView).offset(13)
        }
        
        self.lblNumber.text = "Number"
        self.lblNumber.font = UIFont.openSans(12)
        self.lblNumber.textColor = UIColor.black69
        self.lblNumber.textAlignment = .left
        self.lblNumber.numberOfLines = 1
        infoView.addSubview(self.lblNumber)
        self.lblNumber.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.lblNumber.snp.makeConstraints { (make) in
            make.left.equalTo(self.lblTitle.snp.left)
            make.top.equalTo(self.lblTitle.snp.bottom)
        }
        
        self.segmentControl = VincereSegmentControl(items: titles)
        self.segmentControl.frame = CGRect(x: 0, y: infoView.frame.origin.y + infoView.frame.height, width: ScreenSize.SCREEN_WIDTH, height: 2)
        self.segmentControl.indicatorStyle = .full
        self.segmentControl.selectedSegmentIndex = 0
        
        self.view.addSubview(segmentControl)
        
        contentTopConstraint.constant += segmentControl.frame.height
        
    }
    
    override func initSegmentStyle() {
        
        segmentControl.removeBorder(.clear, .white, UIColor.white.withAlphaComponent(0.5))
        segmentControl.initWithIndicatorStyle(indicatorHeight: 2.0, indicatorColor: .tomato, indicatorStyle: .full)
        segmentControl.addTarget(self, action: #selector(self.didChangeSegmentValue(_:)), for: .valueChanged)
        
    }
}
