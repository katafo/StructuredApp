//
//  AppNavigationVC.swift
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

class AppNavigationVC: UIViewController {
    
    // Auto layout: Please make sure you have connected this outlet for top constraint of your content view below header view.
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    
    // Show/hide custom navigation bar
    var hiddenHeaderView = false
    
    // Init header view
    lazy var headerView: HeaderView = {
        
        let screen: CGRect = UIScreen.main.bounds
        
        var headerBarHeight: CGFloat = NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT
        
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                let safeAreaTopInset = window.safeAreaInsets.top
                if safeAreaTopInset > 0 {
                    headerBarHeight += (safeAreaTopInset - STATUS_BAR_HEIGHT)
                }
            }
        }
        
        let headerBar = HeaderView(frame: CGRect(x: 0, y: 0, width: screen.size.width, height: headerBarHeight))
        headerBar.showBottomUnderline = false
        headerBar.backgroundColor = .yellow
        headerBar.navigationBar.barTintColor = .yellow
        
        return headerBar
        
    }()
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        guard !hiddenHeaderView else { return }
        view.addSubview(headerView)
        setUpLeftBarButton()
        setUpRightBarButton()

        guard contentTopConstraint != nil else { Logger.log(message: "Missing @IBOutlet contentTopConstraint !", event: .error); return }
        contentTopConstraint.constant = headerView.frame.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        //Enable swipe back when hidden navigation bar
        navigationController?.interactivePopGestureRecognizer?.delegate = self
  
    }
    
    func setUpLeftBarButton() {}
    func setUpRightBarButton() {}

}

//MARK: - GESTURE DELEGATE

extension AppNavigationVC: UIGestureRecognizerDelegate{
    
    ///Prevent side effects, only allow swipe back when viewControllers stack > 1
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController else { return false }
        return navigationController.viewControllers.count > 1
    }
    
}
