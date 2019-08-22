//
//  PageVC.swift
//
//  Copyright © 2017. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var currentIndex = 0
    
    weak var pageDelegate: PageDelegate?
    
    var enableSwipe: Bool = true {
        didSet {
            for view in self.view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = enableSwipe
                }
            }
        }
    }
    
    var orderedVC: [UIViewController] = [] {
        didSet {
            if let firstVC = orderedVC.first {
                setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
            pageDelegate?.configurationPageViewController?(configurationPageViewController:
                self, didUpdatePageCount: orderedVC.count)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataSource = self
        delegate = self

    }
    
    //MARK: - CONFIG
    
    func next() {
        if currentIndex+1 < orderedVC.count {
            currentIndex += 1
            setViewControllers([orderedVC[currentIndex]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func moveTo(index: Int, direction: UIPageViewControllerNavigationDirection = .reverse, completion: @escaping () -> ()){
        currentIndex = index
        setViewControllers([orderedVC[index]], direction: direction, animated: true, completion: { _ in
            completion()
        })
    }
    
    func hidePageControl(){
        
    }
    
    func addTo(view: UIView, target: UIViewController){
        
        self.view.frame = view.bounds
        target.addChildViewController(self)
        view.addSubview(self.view)
        
        self.moveTo(index: 0, completion: {})
        
    }
    
}

//MARK: - DATASOURCE

extension PageVC : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVC.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedVC.count > previousIndex else {
            return nil
        }
        
        return orderedVC[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVC.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedVC.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedVC[nextIndex]
    }
    
    
}

//MARK: - DELEGATE

extension PageVC : UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedVC.index(of: firstViewController) {
            currentIndex = index
            pageDelegate?.configurationPageViewController?(configurationPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}

@objc protocol PageDelegate : class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter configurationPageViewController: the MainPageVC instance
     - parameter count: the total number of pages.
     */
    
    @objc optional func configurationPageViewController(configurationPageViewController: UIPageViewController,
                                         didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter configurationPageViewController: the MainPageVC instance
     - parameter index: the index of the currently visible page.
     */
    
    @objc optional func configurationPageViewController(configurationPageViewController: UIPageViewController,
                                         didUpdatePageIndex index: Int)
    
}
