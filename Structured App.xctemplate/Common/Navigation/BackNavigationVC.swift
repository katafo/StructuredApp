//
//  BackNavigationVC.swift
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

class BackNavigationVC: AppNavigationVC {
    
    override func setUpLeftBarButton() {
        
        if let navItem = headerView.navigationBar.items?.first {
            
            let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrow"), style: .plain, target: self, action: #selector(self.backAction))
            navItem.leftBarButtonItem = backButtonItem
            
        }
        
    }
    
    //MARK: - ACTION
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

}
