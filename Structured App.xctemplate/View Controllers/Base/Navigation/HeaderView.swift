//
//  HeaderView.swift
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    public var navigationBar: UINavigationBar!
    
    public var showBottomUnderline: Bool! {
        didSet {
            if navigationBar != nil {
                navigationBar.shadowImage = (showBottomUnderline) ? nil : UIImage()
            }
        }
    }
    
    public var title: String? {
        didSet {
            if let items = navigationBar?.items, items.count > 0 {
                items.first?.title = title
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: frame.height - 44, width: frame.width, height: 44))
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        
        let navigationItem = UINavigationItem(title: title ?? "")
        navigationBar.setItems([navigationItem], animated: false)
    
        addSubview(navigationBar)
        
    }
    
    func removeShadow() {
        
    }
    
}

