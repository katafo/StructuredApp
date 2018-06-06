//
//  HTIndicatorView.swift
//
//  Created by UltraHigh
//  Copyright © 2018. All rights reserved.
//

import UIKit

class HTIndicatorView: UIView {
    
    private var circle = UIView()
    private var isNotAnimated: Bool = true
    
    @IBInspectable var indicatorColor: UIColor {
        get {
            return self.color!
        }
        set {
            self.color = newValue
        }
    }
    
    var color: UIColor? {
        didSet {
            if isNotAnimated {
                createIndicator()
            } else {
                isNotAnimated = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        if color == nil {
            self.color = UIColor.white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //MARK: - Config
    
    private func createIndicator() {
        
        for i in 0...4 {
            
            circle = UIView(frame: CGRect(x: self.frame.width / 2, y: self.frame.height / 2, width: 0, height: 0))
            circle.backgroundColor = self.color
            addSubview(circle)
            animate(view: circle, delay: Double(i) / 5 * 1 )
            
        }
    }
    
    private func animate(view: UIView, delay: TimeInterval) {
        
        UIView.animate(withDuration: 1, delay: delay, options: [.curveLinear], animations: {
            view.bounds = CGRect(origin: view.frame.origin, size: CGSize(width: self.frame.width, height: self.frame.height))
            view.layer.cornerRadius = view.frame.width / 2
            view.layer.masksToBounds = view.frame.width / 2 > 0
            view.alpha = 0
        }) { _ in
            view.bounds = CGRect(origin: view.frame.origin, size: .zero)
            view.layer.cornerRadius = view.frame.width / 2
            view.layer.masksToBounds = view.frame.width / 2 > 0
            view.alpha = 1
            self.animate(view: view, delay: 0.5)
        }
        
    }
    
}
