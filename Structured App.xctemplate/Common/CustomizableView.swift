//
//  CustomizableView.swift
//  KidsTV
//
//  Created by Phong Cao on 3/8/19.
//  Copyright © 2019 Phong Cao. All rights reserved.
//

import UIKit

class CustomizableView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var nibNamed: String {
        return String(describing: type(of: self))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    func commonInit() {
        
        Bundle.main.loadNibNamed(nibNamed, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
    }
    
}
