//
//  SegmentNavigationVC.swift
//  Vincere
//
//  Created by Phong Cao on 11/16/17.
//  Copyright © 2017 Trai Nguyen. All rights reserved.
//

import UIKit

// Segment inside navigation bar

class SegmentNavigationVC: AppNavigationVC{
    
    @IBOutlet weak var vwContent: UIView!
    
    var segmentTitles: [String] = ["Segment 1"]
    var segmentControl: VincereSegmentControl!
    var currentSelectedSegmentIndex: Int = 0
    var isLoaded: Bool = false
    
    var indicatorColor: UIColor = .grassyGreen
    var selectedTextColor: UIColor = .grassyGreen
    var normalTextColor: UIColor = .white

    var pageController: PageVC!{
        return childViewControllers.filter({ $0 is PageVC }).first as? PageVC
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        initSegmentControl(titles: segmentTitles)
        initSegmentStyle()
        
        self.configPageVC()
        
        if self.pageController != nil{
            self.pageController.pageDelegate = self
        }
        
    }
    
    //MARK: - CONFIG
    
    func configPageVC() {}
    
    func initSegmentControl(titles: [String]){
        
        let segmentWidth: CGFloat = CGFloat(230).getWidthRatio()
        let segmentX = (ScreenSize.SCREEN_WIDTH - segmentWidth) / 2

        segmentControl = VincereSegmentControl(items: titles)
        segmentControl.frame = CGRect(x: segmentX, y: 0, width: segmentWidth, height: navView.frame.height)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedColor = selectedTextColor
        segmentControl.normalColor = UIColor.white
        navView.addSubview(segmentControl)
        
        view.layoutIfNeeded()
        
    }
    
    func initSegmentStyle(){
        
        segmentControl.removeBorder(.clear, .white, UIColor.white.withAlphaComponent(0.5))
        segmentControl.initWithIndicatorStyle(indicatorHeight: 2.5, indicatorColor: indicatorColor, indicatorStyle: .fitTitle)
        segmentControl.addTarget(self, action: #selector(self.didChangeSegmentValue(_:)), for: .valueChanged)
        
    }
    
    override func setupLeftBarButton() {
        
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(self.tappedLeftButtonItem))
        filterButton.tintColor = .white
        navItem.leftBarButtonItem = filterButton
        
    }
    
    override func setupRightBarButton() {
        let addNewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(self.tappedRightButton))
        navItem.rightBarButtonItem = addNewButton
        
    }
    
    //MARK: - ACTION
    
    @objc func didChangeSegmentValue(_ segment: VincereSegmentControl){
        
        let direction: UIPageViewControllerNavigationDirection  = (segmentControl.selectedSegmentIndex < self.currentSelectedSegmentIndex) ? .reverse : .forward
        pageController.moveTo(index: segmentControl.selectedSegmentIndex, direction: direction) {}
        currentSelectedSegmentIndex = segmentControl.selectedSegmentIndex
        segmentControl.updateIndicatorPosition()
        didChangeSegmentTab()
        
    }
    
    @objc func tappedLeftButtonItem(){}
    @objc func tappedRightButton(){}
    
    func didChangeSegmentTab(){}
    
}

//MARK: - PAGE DELEGATE

extension SegmentNavigationVC: PageDelegate{
    
    func configurationPageViewController(configurationPageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        segmentControl.selectedSegmentIndex = index
        currentSelectedSegmentIndex = index
        segmentControl.updateIndicatorPosition()
        didChangeSegmentTab()
    }
    
}
