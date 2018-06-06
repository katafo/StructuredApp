//
//  ProgressView.swift
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ProgressView {
    
    static let shared = ProgressView()
    var isShowing = false
    var indicator = HTIndicatorView(frame: CGRect(x: 0,y: 0,width: 60,height: 60))
    var containerView = UIView()
    
    private init() {}
  
    func show() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        if !isShowing {
            
            isShowing = true
            
            containerView.frame = window.frame
            containerView.center = window.center
            containerView.backgroundColor = .clear
            
            indicator.center = containerView.center
            indicator.color = .black
            containerView.addSubview(indicator)
            
            window.addSubview(containerView)
            
        }
    }
    
    func hide() {
        
        isShowing = false
        indicator.removeFromSuperview()
        containerView.removeFromSuperview()
        
    }
    
}
